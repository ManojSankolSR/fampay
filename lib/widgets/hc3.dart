//

import 'package:fampay/global/constants.dart';
import 'package:fampay/models/call_to_action.dart' as famCards;
import 'package:fampay/models/card.dart' as famCards;
import 'package:fampay/models/card_group.dart' as famCards;
import 'package:fampay/models/deleted_card.dart';
import 'package:fampay/models/formatted_text.dart' as famCards;
import 'package:fampay/providers/Contextual_Cards_Data_Provider.dart';
import 'package:fampay/widgets/custom_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Hc3 extends ConsumerStatefulWidget {
  final famCards.CardGroup hc3CardGroupData;

  final String slugId ;

  const Hc3( {super.key, required this.hc3CardGroupData, required this.slugId});

  @override
  _Hc3State createState() => _Hc3State();
}

class _Hc3State extends ConsumerState<Hc3> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  bool _isForegroundVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(.45, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cards = widget.hc3CardGroupData.cards;
    final height = widget.hc3CardGroupData.height != null
        ? widget.hc3CardGroupData.height!.toDouble()
        : 400;

    if (cards.isEmpty) {
      return SizedBox();
    }

    return SizedBox(
      height: height - 200,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: Constants.scrollViewHorizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final formattedTitle = cards[index].formattedTitle;
          final cta = cards[index].cta;
          final cardGroupId = widget.hc3CardGroupData.id;
          final cardId = cards[index].id;

          return GestureDetector(
            onTap: () {
              if (!_isForegroundVisible) {
                _animationController.reverse();
              }

              setState(() {
                _isForegroundVisible = !_isForegroundVisible;
              });
            },
            onLongPress: () {
              if (_isForegroundVisible) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }

              setState(() {
                _isForegroundVisible = !_isForegroundVisible;
              });
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: size.width - Constants.scrollViewHorizontalPadding * 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _background(widget.hc3CardGroupData.height!.toDouble(),
                      cardGroupId, cardId),
                  _foreground(
                    cards,
                    cta,
                    index,
                    size,
                    formattedTitle,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _foreground(
      List<famCards.Card> cards,
      List<famCards.CallToAction>? cta,
      int index,
      Size size,
      famCards.FormattedText? formattedTitle) {
    return SlideTransition(
      position: _slideAnimation,
      child: AspectRatio(
        aspectRatio: cards[0].bgImage!.aspectRatio!,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(cards[index].bgImage!.imageUrl!),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            height: widget.hc3CardGroupData.height!.toDouble() - 300,
            child: Column(
              crossAxisAlignment: Constants.getCrossAxisAlignmentFromString(
                  formattedTitle!.align),
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 40,
              children: [
                ...List.generate(
                  formattedTitle.entities.length,
                  (i) => Text(
                    
                    formattedTitle.entities[i].text!,
                    textAlign:
                        Constants.getTextAlignFromString(formattedTitle.align),
                    style: TextStyle(

                      decoration: Constants.getTextDecorationFromStyle(formattedTitle.entities[i].fontStyle),
                      
                      fontWeight: Constants.getFontWeightFromFamily(
                          formattedTitle.entities[i].fontFamily),
                      fontSize: formattedTitle.entities[i].fontSize?.toDouble(),
                      color: Constants.hexToColorWithAlpha(
                          formattedTitle.entities[i].color!),
                    ),
                  ),
                ),
                ...List.generate(
                  cta!.length,
                  (i) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Constants.hexToColorWithAlpha(cta[i].bgColor!),
                      shape: RoundedRectangleBorder(
                        borderRadius: cta[i].isCircular
                            ? BorderRadius.circular(50)
                            : BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Constants.launchUrl(cards[index].url, context);
                    },
                    child: Text(cta[i].text,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _background(double height, String cardGroupId, String cardId) {
    final DeletedCard deletedCard=DeletedCard(cardGroupId: cardGroupId, cardId: cardId, slugId: widget.slugId);
    return Container(
      padding: EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconTextButton(icon: "assets/images/bell_icon.png", title: "remind later", color: Theme.of(context).scaffoldBackgroundColor, onpress: () {
            ref
                .read(contextualCardsProvider.notifier)
                .deleteCardPermanently(deletedCard: deletedCard);
          }),
          SizedBox(height: height * .08),
          CustomIconTextButton(icon: "assets/images/dismiss_icon.png", title: "dismiss now", color: Theme.of(context).scaffoldBackgroundColor, onpress: () {
            ref
                .read(contextualCardsProvider.notifier)
                .deleteCardTemproarily(deletedCard: deletedCard, fromDelPermanent: false);
          }),
        ],
      ),
    );
  }
}

