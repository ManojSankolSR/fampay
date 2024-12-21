import 'dart:ffi';

import 'package:fampay/Hive_Boxes/HiveBoxes.dart';
import 'package:fampay/global/constants.dart';
import 'package:fampay/models/api_response.dart';
import 'package:fampay/providers/Contextual_Cards_Data_Provider.dart';
import 'package:fampay/widgets/hc1.dart';
import 'package:fampay/widgets/hc3.dart';
import 'package:fampay/widgets/hc5.dart';
import 'package:fampay/widgets/hc6.dart';
import 'package:fampay/widgets/hc9.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // Future<void> _refreshPage(WidgetRef ref) async {
  //   final data = await ref.refresh(fetchContextualCardsProvider.future);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api_response = ref.watch(contextualCardsProvider);

    return Scaffold(
        appBar: AppBar(
          
          title: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("fampay"),
              Image.asset(
                "assets/images/fampay_logo.png",
                width: 30,
                height: 30,
              )
            ],
          ),
          
          actions: [
            IconButton(onPressed: () async{

              HiveBoxes.removeAllDeletedCards(context: context,ref: ref);

            }, icon: Icon(Icons.clear_all))
          ],

          centerTitle: true,
         
        ),
        body: 
        switch (api_response) {
          AsyncData(:final value) => _data(value, ref),
          AsyncError(:final error) => _error(error),
          _ => _loader()
        }

        // api_response.when(
        //     data: (data) => _data(data, ref), error: _error, loading: _loader)
        );
  }

  Widget _loader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(Object error) {
    return Center(
      child: Text("Some Erroe Occured"),
    );
  }

  Widget _data(ApiResponse data, WidgetRef ref) {
    final hc1CardGroupData =
        data.cardGroups.firstWhere((e) => e.designType == "HC1");
    final hc3CardGroupData =
        data.cardGroups.firstWhere((e) => e.designType == "HC3");
    final hc5CardGroupData =
        data.cardGroups.firstWhere((e) => e.designType == "HC5");
    final hc6CardGroupData =
        data.cardGroups.firstWhere((e) => e.designType == "HC6");
    final hc9CardGroupData =
        data.cardGroups.firstWhere((e) => e.designType == "HC9");

    print("rebuilt ${hc3CardGroupData.toJson()}");

    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await ref.refresh(contextualCardsProvider.future);
          },
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 30),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Hc3(
                  hc3CardGroupData: hc3CardGroupData,
                ),
                Hc6(
                  hc6CardGroupData: hc6CardGroupData,
                ),
                Hc5(
                  hc5CardGroupData: hc5CardGroupData,
                ),
                Hc9(
                  hc9CardGroupData: hc9CardGroupData,
                ),
                Hc1(
                  hc1CardGroupData: hc1CardGroupData,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
