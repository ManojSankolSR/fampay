import 'package:fampay/global/constants.dart';
import 'package:fampay/providers/Contextual_Cards_Data_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class HiveBoxes {
  static late Box<Map<dynamic, dynamic>> deletedCards;

  static late Box<Map<dynamic, dynamic>> tempdeletedCards;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    deletedCards = await Hive.openBox<Map<dynamic, dynamic>>("deletedCards");
    tempdeletedCards = await Hive.openBox<Map<dynamic, dynamic>>("tempdeletedCards");
    await tempdeletedCards.clear();
  }

  static addTempDeletedCard(String cardGroupId, String cardId) {
    tempdeletedCards.add({"cardGroupId": cardGroupId, cardId: "cardId"});
  }

  static List<Map<dynamic, dynamic>> getTempDeletedCards() {
    return tempdeletedCards.values.toList();
  }


  

  static addDeletedCard(String cardGroupId, String cardId) {
    deletedCards.add({"cardGroupId": cardGroupId, cardId: "cardId"});
  }

  static List<Map<dynamic, dynamic>> getDeletedCards() {
    return deletedCards.values.toList();
  }

  static removeAllDeletedCards({required BuildContext context,required WidgetRef ref}) {
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
