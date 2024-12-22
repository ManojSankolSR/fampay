import 'dart:convert';

import 'package:fampay/Hive_Boxes/HiveBoxes.dart';
import 'package:fampay/models/api_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part "Contextual_Cards_Data_Provider.g.dart";

@riverpod
class ContextualCards extends _$ContextualCards {
  Future<ApiResponse> fetchContextualCards() async {
    final response = await http.get(Uri.parse(
        "https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage"));
    final body = response.body;

    final decodedBody = json.decode(body);

    ApiResponse ContextualCards = ApiResponse.fromJson(decodedBody[0]);

    // Getting temprorary and Permenant deletd cards data from Hive

    final tempdeletedCards = HiveBoxes.getTempDeletedCards();
    final deletedCards = HiveBoxes.getDeletedCards();

    deletedCards.addAll(tempdeletedCards);

    //Removig deleted cards from cardsGroups that we got from api

    for (var deletedCard in deletedCards) {
      final cardGroupId = deletedCard!['cardGroupId'];
      final cardId = deletedCard['cardId'];

      final updatedCardGroups = ContextualCards.cardGroups.map((cardGroup) {
        if (cardGroup.id == cardGroupId) {
          final updatedCards = cardGroup.cards.where((card) {
            return card.id == cardId;
          }).toList();

          final updatedGroup = cardGroup.copyWith(updatedCards: updatedCards);

          return updatedGroup;
        }

        return cardGroup;
      }).toList();

      ContextualCards = ContextualCards.copyWith(cardGroups: updatedCardGroups);
    }

    return ContextualCards;
  }

  @override
  FutureOr<ApiResponse> build() async {
    return fetchContextualCards();
  }

  Future deleteCardTemproarily(
      String cardGroupId, String cardId, bool fromDelPermanent) async {
    final data = state.asData?.value;

    if (data == null) {
      return;
    }

    final updatedCardGroups = data.cardGroups.map((cardGroup) {
      if (cardGroup.id == cardGroupId) {
        final updatedCards =
            cardGroup.cards.where((card) => card.id != cardId).toList();

        final a = cardGroup.copyWith(updatedCards: updatedCards);

        return a;
      }

      return cardGroup;
    }).toList();

    if (!fromDelPermanent) {
      HiveBoxes.addTempDeletedCard(cardGroupId, cardId);
    }

    state = AsyncValue.data(data.copyWith(cardGroups: updatedCardGroups));  
  }

  Future deleteCardPermanently(String cardGroupId, String cardId) async {
    final data = state.asData?.value;

    if (data == null) {
      return;
    }

    deleteCardTemproarily(cardGroupId, cardId, true);

    HiveBoxes.addDeletedCard(cardGroupId, cardId);
  }
}
