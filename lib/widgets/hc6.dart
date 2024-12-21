import 'package:fampay/global/constants.dart';

import 'package:fampay/models/card_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hc6 extends StatelessWidget {
  final CardGroup hc6CardGroupData;
  const Hc6({super.key, required this.hc6CardGroupData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isFullWidth = hc6CardGroupData.isFullWidth;

    final cards = hc6CardGroupData.cards;
    // TODO: implement build
    return SizedBox(
        height: hc6CardGroupData.height!.toDouble(),

        // color: Colors.red,
        child: ListView.builder(
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
                      ? size.width - Constants.scrollViewHorizontalPadding * 2
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          height:
                              // hc3.height!.toDouble(),
                              card.iconSize!.toDouble(),
                          card.icon!.imageUrl!,
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
                                
                                textAlign: Constants.getTextAlignFromString(
                                    formattedTitle.align),
                                formattedTitle.entities[i].text!,
                                style: TextStyle(
                                     decoration: Constants.getTextDecorationFromStyle(formattedTitle.entities[i].fontStyle),
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
                        if (isFullWidth) Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: card.iconSize!.toDouble(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
