import 'package:fampay/Hive_Boxes/HiveBoxes.dart';
import 'package:fampay/global/constants.dart';

import 'package:fampay/models/card_group.dart';
import 'package:flutter/material.dart';
import 'package:fampay/models/card.dart' as famCards;

class Hc1 extends StatelessWidget {
  final CardGroup hc1CardGroupData;
  const Hc1({super.key, required this.hc1CardGroupData});

  @override
  Widget build(BuildContext context) {
    final cards = hc1CardGroupData.cards;

    final size = MediaQuery.of(context).size;

    final isFullWidth = hc1CardGroupData.isFullWidth;

    final isScrollable = hc1CardGroupData.isScrollable;

    if (isScrollable) {
      return _scrollableWidget(
          cards: cards, size: size, isFullWidth: isFullWidth, context: context);
    } else {
      return _nonScrollableWidget(
          cards: cards, size: size, isFullWidth: isFullWidth, context: context);
    }
  }

  Widget _scrollableWidget(
      {required List<famCards.Card> cards,
      required Size size,
      required bool isFullWidth,
      required BuildContext context}) {
    return SizedBox(
        height: hc1CardGroupData.height!.toDouble(),

        // color: Colors.red,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 10,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: Constants.scrollViewHorizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final formattedTitle = cards[index].formattedTitle;
            final card = cards[index];

            return Material(
              borderRadius: BorderRadius.circular(10),
              color: Constants.hexToColorWithAlpha(card.bgColor!),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Constants.launchUrl(card.url, context);
                },
                child: SizedBox(
                  width: isFullWidth
                      ? size.width - Constants.scrollViewHorizontalPadding*2
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: card.icon!.aspectRatio!,
                          child: Image.network(
                            card.icon!.imageUrl!,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              formattedTitle!.entities.length,
                              (i) => Text(
                                formattedTitle.entities[i].text!,
                                textAlign: Constants.getTextAlignFromString(
                                    formattedTitle.align),
                                style: TextStyle(
                                    decoration:
                                        Constants.getTextDecorationFromStyle(
                                            formattedTitle
                                                .entities[i].fontStyle),
                                    fontWeight:
                                        Constants.getFontWeightFromFamily(
                                            formattedTitle
                                                .entities[i].fontFamily),
                                    fontSize: formattedTitle
                                        .entities[i].fontSize
                                        ?.toDouble(),
                                    color: Constants.hexToColorWithAlpha(
                                        formattedTitle.entities[i].color!)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget _nonScrollableWidget(
      {required List<famCards.Card> cards,
      required Size size,
      required bool isFullWidth,
      required BuildContext context}) {
    return SizedBox(
      width: size.width - Constants.scrollViewHorizontalPadding,
      child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(2, (index) {
            final formattedTitle = cards[index].formattedTitle;
            final card = cards[index];
            return Material(
              borderRadius: BorderRadius.circular(10),
              color: Constants.hexToColorWithAlpha(card.bgColor!),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Constants.launchUrl(card.url, context);
                },
                child: SizedBox(
                  width: isFullWidth
                      ? size.width - Constants.scrollViewHorizontalPadding
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisSize:
                          isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: AspectRatio(
                            aspectRatio: card.icon!.aspectRatio!,
                            child: Image.network(
                              card.icon!.imageUrl!,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              formattedTitle!.entities.length,
                              (i) => Text(
                                formattedTitle.entities[i].text!,
                                textAlign: Constants.getTextAlignFromString(
                                    formattedTitle.align),
                                style: TextStyle(
                                    decoration:
                                        Constants.getTextDecorationFromStyle(
                                            formattedTitle
                                                .entities[i].fontStyle),
                                    fontWeight:
                                        Constants.getFontWeightFromFamily(
                                            formattedTitle
                                                .entities[i].fontFamily),
                                    fontSize: formattedTitle
                                        .entities[i].fontSize
                                        ?.toDouble(),
                                    color: Constants.hexToColorWithAlpha(
                                        formattedTitle.entities[i].color!)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
