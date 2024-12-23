import 'package:fampay/global/constants.dart';
import 'package:fampay/models/deleted_card.dart';
import 'package:fampay/providers/Contextual_Cards_Data_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class HiveBoxes {
  static late Box<DeletedCard> deletedCards;

  static late Box<DeletedCard> tempdeletedCards;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(DeletedCardAdapter());

    deletedCards = await Hive.openBox<DeletedCard>("deletedCards");
    tempdeletedCards =
        await Hive.openBox<DeletedCard>("tempdeletedCards");
    await tempdeletedCards.clear();
  }

  static addTempDeletedCard({required DeletedCard deletedCard}) {
    tempdeletedCards
        .add(deletedCard);
  }

  static List<DeletedCard> getTempDeletedCards() {
    return tempdeletedCards.values.toList();
  }

  static addDeletedCard({required DeletedCard deletedCard}) {
    deletedCards
        .add(deletedCard);
  }

  static List<DeletedCard> getDeletedCards() {
    return deletedCards.values.toList();
  }

  static removeAllDeletedCards(
      {required BuildContext context, required WidgetRef ref}) {
    if (deletedCards.values.isNotEmpty || tempdeletedCards.values.isNotEmpty) {
      deletedCards.clear();
      tempdeletedCards.clear();

      Constants.customToast(
              title: "Cleared All Deleted Cards Data",
              icon: Icons.clear_all_outlined)
          .show(context);
      ref.refresh(contextualCardsProvider.future);
    } else {
      Constants.customToast(
              title: "No Deleted Cards To Clear", icon: Icons.clear)
          .show(context);
    }
  }
}
