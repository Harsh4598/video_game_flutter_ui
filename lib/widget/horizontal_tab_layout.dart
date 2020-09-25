import 'package:flutter/material.dart';
import 'package:games_flutter_app/model/forum.dart';
import 'package:games_flutter_app/widget/forum_card.dart';
import 'package:games_flutter_app/widget/tab_text.dart';

class HorizontalTabLayout extends StatefulWidget {
  @override
  _HorizontalTabLayoutState createState() => _HorizontalTabLayoutState();
}

class _HorizontalTabLayoutState extends State<HorizontalTabLayout>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 2;
  Animation<double> animation;
  AnimationController animationController;
  Animation<Offset> slideanimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = Tween<double>(begin: 0, end: 1.0).animate(animationController);
    slideanimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.05, 0))
        .animate(animationController);
  }

  playAnimation() {
    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -40,
            bottom: 0,
            top: 0,
            width: 120,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 48.0, horizontal: 3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TabText(
                    text: "Media",
                    isSelected: selectedTabIndex == 0,
                    onTabTap: () {
                      onTabTap(0);
                    },
                  ),
                  TabText(
                    text: "Streamers",
                    isSelected: selectedTabIndex == 1,
                    onTabTap: () {
                      onTabTap(1);
                    },
                  ),
                  TabText(
                    text: "Forum",
                    isSelected: selectedTabIndex == 2,
                    onTabTap: () {
                      onTabTap(2);
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 60.0,
            ),
            child: FutureBuilder(
              future: playAnimation(),
              builder: (context, snapshot) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: slideanimation,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: getList(selectedTabIndex),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getList(index) {
    return [
      [
        ForumCard(forum: fortniteForum),
        ForumCard(forum: pubgForum),
      ],
      [
        ForumCard(forum: pubgForum),
        ForumCard(forum: fortniteForum),
      ],
      [
        ForumCard(forum: fortniteForum),
        ForumCard(forum: pubgForum),
      ]
    ][index];
  }

  onTabTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}
