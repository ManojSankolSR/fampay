import 'dart:ffi';

import 'package:fampay/Hive_Boxes/HiveBoxes.dart';
import 'package:fampay/global/constants.dart';
import 'package:fampay/models/slug_item.dart';
import 'package:fampay/models/slug_list.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slugList = ref.watch(contextualCardsProvider);

    return Scaffold(
        appBar: _appBar(context, ref),
        body: slugList.when(
            data: (data) => _data(data, ref),
            error: (error, stackTrace) => _error(error, stackTrace, ref),
            loading: _loader));
  }

  PreferredSizeWidget _appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
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
        IconButton(
            onPressed: () async {
              HiveBoxes.removeAllDeletedCards(context: context, ref: ref);
            },
            icon: Icon(Icons.clear_all))
      ],
      centerTitle: true,
    );
  }

  Widget _loader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(Object error, StackTrace stackTrace, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: 80,
        ),
        Text(
          "Some Error Occurred",
          textAlign: TextAlign.center,
        ),
        UnconstrainedBox(
          child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                ref.invalidate(contextualCardsProvider);
              },
              child: Text("Refresh")),
        )
      ],
    );
  }

  Widget _data(SlugList data, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await ref.refresh(contextualCardsProvider.future);
          },
        ),
        SliverPadding(
            padding: EdgeInsets.only(top: 20, bottom: 40),
            sliver: SliverList.builder(
              itemCount: data.responses.length,
              itemBuilder: (context, index) {
                final currentSlug = data.responses[index];

                final hc1CardGroupData = currentSlug.cardGroups
                    .firstWhere((e) => e.designType == "HC1");
                final hc3CardGroupData = currentSlug.cardGroups
                    .firstWhere((e) => e.designType == "HC3");
                final hc5CardGroupData = currentSlug.cardGroups
                    .firstWhere((e) => e.designType == "HC5");
                final hc6CardGroupData = currentSlug.cardGroups
                    .firstWhere((e) => e.designType == "HC6");
                final hc9CardGroupData = currentSlug.cardGroups
                    .firstWhere((e) => e.designType == "HC9");

                final slugId = currentSlug.id;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Hc3(
                      slugId: slugId,
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
                );
              },
            ))
      ],
    );
  }
}
