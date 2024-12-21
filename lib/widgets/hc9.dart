import 'package:fampay/global/constants.dart';

import 'package:fampay/models/card_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hc9 extends StatelessWidget {

   final CardGroup hc9CardGroupData;

  const Hc9({super.key, required this.hc9CardGroupData});

  @override
  Widget build(BuildContext context) {

      



    final cards = hc9CardGroupData.cards;
    final height= hc9CardGroupData.height!=null ? hc9CardGroupData.height!.toDouble() : 200.0 ;
    // TODO: implement build
    return Container(
      // color: Colors.red,
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 15,),
            padding: EdgeInsets.symmetric(horizontal: Constants.scrollViewHorizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final formattedTitle = cards[index].formattedTitle;
            final card = cards[index];

            return AspectRatio(
              aspectRatio: card.bgImage!.aspectRatio!,
              child: InkWell(
                onTap: () {
                  Constants.launchUrl(card.url, context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                
                             
                 decoration: BoxDecoration(
                   image: DecorationImage(image: NetworkImage(card.bgImage!.imageUrl!)),
                  borderRadius: BorderRadius.circular(10),
                  gradient: card.bgGradient!.toLinearGradient()
                 ),
                
                ),
              ),
            );
          },
        ),
    );
  }
  
}