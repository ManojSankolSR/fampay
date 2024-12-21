import 'package:fampay/global/constants.dart';

import 'package:fampay/models/card_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hc5 extends StatelessWidget {

     final CardGroup hc5CardGroupData;

  const Hc5({super.key, required this.hc5CardGroupData});
  @override
  Widget build(BuildContext context) {
      

    final size = MediaQuery.of(context).size;

    final cards = hc5CardGroupData.cards;
    final height= hc5CardGroupData.height!=null ? hc5CardGroupData.height!.toDouble() : 165.0 ;
   return SizedBox(
    height: cards.isNotEmpty? height :null,

    child: ListView.builder(
      
            padding: EdgeInsets.symmetric(horizontal: Constants.scrollViewHorizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final formattedTitle = cards[index].formattedTitle;
            final card = cards[index];

            return AspectRatio(
              aspectRatio: card.bgImage!.aspectRatio!,

              child:
               InkWell(
                onTap: () {
                  Constants.launchUrl(card.url, context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(card.bgImage!.imageUrl!))
                 ),
                
                ),
              ),
            );
          },
        ));
  
  

 
  }
  
  
}