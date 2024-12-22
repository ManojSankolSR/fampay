import 'dart:convert';

import 'package:fampay/Hive_Boxes/HiveBoxes.dart';
import 'package:fampay/models/deleted_card.dart';
import 'package:fampay/models/slug_item.dart';
import 'package:fampay/models/slug_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part "Contextual_Cards_Data_Provider.g.dart";

@riverpod
class ContextualCards extends _$ContextualCards {
  Future<SlugList> fetchContextualCards() async {
    final response = await http.get(Uri.parse(
        "https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage"));
    final body = response.body;

    final decodedBody = json.decode(body);

    SlugList slugList = SlugList.fromJson(decodedBody);

    // Getting temprorary and Permenant deletd cards data from Hive

    final tempdeletedCards = HiveBoxes.getTempDeletedCards();
    final deletedCards = HiveBoxes.getDeletedCards();

    deletedCards.addAll(tempdeletedCards);

    //Removig deleted cards from sluglist that we got from api

    print("delobs $deletedCards");

    for (var deletedCard in deletedCards) {
      final cardGroupId = deletedCard.cardGroupId;
      final cardId = deletedCard.cardId;
      final slugId = deletedCard.slugId;

      final updatedSlugList = slugList.responses.map((e) {
        //iterating over slugs to find slug with same slugId that we got from deleted cards
        if (e.id == slugId) {

          //iterating over cardGroups to find cardGroup with same cardGroupId that we got from deleted cards
          final updatedSlugList = e.cardGroups.map((cardGroup) {
            if (cardGroup.id == cardGroupId) {

              //iterating over cards to find and remove specific card with same cardId that we got from deleted cards
              final updatedCards = cardGroup.cards.where((card) {
                return card.id != cardId;
              }).toList();

              return cardGroup.copyWith(updatedCards: updatedCards);
            }
            return cardGroup;
          }).toList();

          return e.copyWith(cardGroups: updatedSlugList);
        }
        return e;
      }).toList();

      slugList = slugList.copyWith(responses: updatedSlugList);
    }

    return slugList;
  }

  @override
  FutureOr<SlugList> build() async {
    return fetchContextualCards();
  }

  Future deleteCardTemproarily({required DeletedCard deletedCard,required bool fromDelPermanent}) async {
    SlugList? slugList = state.asData?.value;

    if (slugList == null) {
      return;
    }

    final updatedSlugList = slugList.responses.map((e) {
      if (e.id == deletedCard.slugId) {
        final updatedSlugList = e.cardGroups.map((cardGroup) {
          if (cardGroup.id == deletedCard.cardGroupId) {
            final updatedCards = cardGroup.cards.where((card) {
              return card.id != deletedCard.cardId;
            }).toList();

            return cardGroup.copyWith(updatedCards: updatedCards);
          }
          return cardGroup;
        }).toList();

        return e.copyWith(cardGroups: updatedSlugList);
      }
      return e;
    }).toList();

    if (!fromDelPermanent) {
      HiveBoxes.addTempDeletedCard(deletedCard: deletedCard);
    }

    state = AsyncValue.data(slugList.copyWith(responses: updatedSlugList));
  }

  void deleteCardPermanently({required DeletedCard deletedCard,}) {
    deleteCardTemproarily(deletedCard: deletedCard,fromDelPermanent: true);

    HiveBoxes.addDeletedCard(deletedCard: deletedCard);
  }
}
