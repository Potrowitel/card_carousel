import 'package:card_carousel/src/models/card.dart';
import 'package:card_carousel/src/models/scrollAnim.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///CardsCarousel
class CardsCarousel extends StatefulWidget {
  final List<CardModel> cards;
  const CardsCarousel({required this.cards, Key? key}) : super(key: key);

  @override
  _CardsCarouselState createState() => _CardsCarouselState();
}

class _CardsCarouselState extends State<CardsCarousel> {
  late ScrollController scrollController;
  late double mediaWidth;

  late CustomScrollPhysics _physics;
  ScrollAnimModel scrollInfo = ScrollAnimModel(
      currentCard: 0,
      previousScale: 0.0,
      currentScale: 0.0,
      currentMargin: 0.0,
      previousMargin: 0.0,
      direction: ScrollDirection.idle,
      percent: 0);

  int currentCard = 0;
  int previousCard = 0;
  double width = 256;
  double dimension = 266;
  double margin = 0.0;
  double currentScale = 1.0;
  double previousScale = 1.0;

  //int addButtonDuration = 5;
  // bool isAnimBack = false;
  // bool isTimerEnded = false;
  //late Timer timer;

  @override
  void initState() {
    super.initState();
    _physics = CustomScrollPhysics(itemDimension: dimension);
    scrollController = ScrollController(initialScrollOffset: 0.01);

    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    // timer.cancel();
    scrollController.removeListener(scrollListener);
  }

  ScrollAnimModel getInfo(int startOffset) {
    double itemWidth = (width + 10);
    double scrollOffset = scrollController.offset + startOffset;
    int itemIndex = 0;
    itemIndex = scrollOffset < itemWidth
        ? 0
        : ((scrollOffset - (width + 10)) / itemWidth).ceil();
    int percent =
        ((scrollOffset - (itemWidth * itemIndex)) ~/ (itemWidth / 100));

    return ScrollAnimModel(
      currentCard: itemIndex,
      currentScale: 0.0,
      previousScale: 0.0025 * percent,
      currentMargin: 0.0,
      previousMargin: 0.0,
      direction: scrollController.position.userScrollDirection,
      percent: percent,
    );
  }

  void scrollListener() {
    ScrollAnimModel forward = getInfo(210);
    forward.currentScale = 0.0025 * forward.percent;
    forward.currentMargin = 0.3 * forward.percent;
    forward.previousScale = (0.0025 * 100) - (0.0025 * forward.percent);
    forward.previousMargin = (0.3 * 100) - (0.3 * forward.percent);

    setState(() {
      // if (scrollController.offset > 0) animBack();

      currentCard = forward.currentCard;
      if (scrollController.position.haveDimensions) {
        _physics = CustomScrollPhysics(itemDimension: dimension);
      }
      scrollInfo = forward;
    });
  }

  // void animBack() async {
  //   isAnimBack = true;
  //   Timer.periodic(Duration(milliseconds: 20), (timer) {
  //     if (_controller.value > 0) {
  //       _controller.setValue(_controller.value - 0.1);
  //     }
  //     if (_controller.value <= 0) {
  //       timer.cancel();
  //     }
  //   });
  //   // (Duration(milliseconds: 1), () {
  //   //   if (_controller.value > 0) {
  //   //     _controller.setValue(_controller.value - 0.1);
  //   //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    mediaWidth = MediaQuery.of(context).size.width;
    return Center(
      // child: NotificationListener<OverscrollNotification>(
      //   onNotification: (detail) {
      //     if (detail.dragDetails!.localPosition.dx <= 150) {
      //       setState(() {
      //         print(padding);
      //         padding = detail.dragDetails!.localPosition.dx;
      //         //print(detail.dragDetails!.localPosition.dx);
      //       });
      //     }
      //     return false;
      //   },
      //   child: Container(
      //     padding: EdgeInsets.only(left: padding),
      //     child: ListView.builder(
      //       controller: scrollController,
      //       physics: _physics,
      //       scrollDirection: Axis.horizontal,
      //       itemCount: widget.cards.length + 2,
      //       itemBuilder: (context, index) {
      //         if (index == 0 || index >= widget.cards.length + 1) {
      //           return Container(width: 20);
      //         } else {
      //           bool current = (index - 1) == currentCard;
      //           return BankCard(
      //               key: Key((index - 1).toString()),
      //               card: widget.cards[index - 1],
      //               cardWidth: width,
      //               currentCard: currentCard,
      //               scrollInfo: scrollInfo,
      //               current: current);
      //         }
      //       },
      //     ),
      //   ),
      // ),

      // child: Stack(
      //   alignment: Alignment.center,
      //   children: [
      //     Container(
      //       height: 300,
      //       child: DragableAddButton(
      //           armedToLoadingDuration: Duration(seconds: 1),
      //           draggingToIdleDuration: Duration(seconds: 2),
      //           completeStateDuration: Duration(seconds: 0),
      //           loadingToIdleDuration: Duration(seconds: 1),
      //           leadingGlowVisible: false,
      //           trailingGlowVisible: false,
      //           offsetToArmed: 100.0,
      //           onTimer: () {
      //             return Timer(Duration(seconds: 5), () {});
      //           },
      //           onRefresh: () {
      //             if (isAnimBack) {
      //               return true;
      //             } else {
      //               return false;
      //             }
      //           },
      //           controller: _controller,
      //           child: ListView.builder(
      //             controller: scrollController,
      //             physics: _physics,
      //             scrollDirection: Axis.horizontal,
      //             itemCount: widget.cards.length + 2,
      //             itemBuilder: (context, index) {
      //               if (index == 0 || index >= widget.cards.length + 1) {
      //                 return Container(width: 20);
      //               } else {
      //                 bool current = (index - 1) == currentCard;
      //                 return BankCard(
      //                     key: Key((index - 1).toString()),
      //                     card: widget.cards[index - 1],
      //                     cardWidth: width,
      //                     currentCard: currentCard,
      //                     scrollInfo: scrollInfo,
      //                     current: current);
      //               }
      //             },
      //           ),
      //           builder: (
      //             BuildContext context,
      //             Widget child,
      //             IndicatorController controller,
      //           ) {
      //             return Container(
      //               alignment: Alignment.centerLeft,
      //               child: Stack(
      //                 children: <Widget>[
      //                   Container(
      //                     height: double.infinity,
      //                     width: 100,
      //                     //    color: Colors.amber,
      //                     child: Visibility(
      //                       visible: scrollController.positions.isNotEmpty
      //                           ? scrollController.offset > width - 50
      //                               ? false
      //                               : true
      //                           : true,
      //                       child: AddCardButton(),
      //                     ),
      //                   ),
      //                   Container(
      //                     margin: const EdgeInsets.only(left: 100),
      //                     width: 50,
      //                     height: double.infinity,
      //                     //  color: Colors.greenAccent,
      //                   ),
      //                   AnimatedBuilder(
      //                     animation: _controller,
      //                     builder: (context, snapshot) {
      //                       return Transform.translate(
      //                         offset: Offset(100 * _controller.value, 0),
      //                         child: child,
      //                       );
      //                     },
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }

      child: ListView.builder(
        controller: scrollController,
        physics: _physics,
        scrollDirection: Axis.horizontal,
        itemCount: widget.cards.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index >= widget.cards.length + 1) {
            return Container();
          } else {
            bool current = (index - 1) == currentCard;
            return BankCard(
                key: Key((index - 1).toString()),
                card: widget.cards[index - 1],
                cardWidth: width,
                currentCard: currentCard,
                scrollInfo: scrollInfo,
                current: current);
          }
        },
      ),

      //             ),
      //       ),
      //       // GestureDetector(
      //       //   onPanUpdate: (detail) {
      //       //     print(detail);
      //       //   },
      //       //   child: Container(
      //       //     width: 200,
      //       //     height: 200,
      //       //     color: Colors.grey.withOpacity(0.0),
      //       //   ),
      //       // ),
      //         ),
      //   ),
      // ],
      // ),
    );
  }
}

///AddCardButton

class AddCardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(18.0),
        height: 44,
        width: 44,
        child: Image.asset('assets/images/4.0x/add.png'),
      ),
    );
  }
}

///BankCard

class BankCard extends StatelessWidget {
  final CardModel card;
  final ScrollAnimModel scrollInfo;
  final double cardWidth;
  final bool current;
  final int currentCard;

  const BankCard(
      {required this.card,
      required this.cardWidth,
      required this.scrollInfo,
      required this.current,
      required this.currentCard,
      Key? key})
      : super(key: key);

  bool isPrevious() {
    int cardKey =
        int.parse(key.toString().substring(3, key.toString().length - 3));
    if (cardKey == currentCard - 1) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0 +
          (current
              ? scrollInfo.currentScale
              : isPrevious()
                  ? scrollInfo.previousScale
                  : 0.0),
      child: Container(
        child: Container(
          margin: EdgeInsets.all(5.0 +
              (current
                  ? scrollInfo.currentMargin
                  : isPrevious()
                      ? scrollInfo.previousMargin
                      : 0.0)),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 152,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          card.gradientTopColor,
                          card.gradietnBottomColor,
                        ],
                        begin: Alignment(-0.8, -0.8),
                        end: Alignment(0.8, 0.8),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -85,
                    top: 0,
                    child: Container(
                      height: 216,
                      width: 216,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF).withOpacity(0.07),
                            Color(0xFFFFFFFF).withOpacity(0.0),
                          ],
                          begin: Alignment(-0.3, -0.8),
                          end: Alignment(-0.5, 0.5),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 23.0,
                    right: 21.0,
                    child: Container(
                      height: 10,
                      child: card.cardType,
                    ),
                  ),
                  Positioned(
                    top: 14.0,
                    left: 16.0,
                    child: Container(
                      height: 26.0,
                      child: card.logo,
                    ),
                  ),
                  Positioned(
                    bottom: 21.0,
                    left: 16.0,
                    child: Container(
                      child: Text(
                        card.title,
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Regular',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    child: Container(
                      child: Text(
                        card.balance,
                        style: TextStyle(
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15.0,
                    right: 19.0,
                    child: Container(
                      child: Text(
                        '•••• ${card.number}',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Image.asset(
                    'assets/images/noise.png',
                    package: 'card_carousel',
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///CustomScrollPhysics

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;
  CustomScrollPhysics({required this.itemDimension, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
