import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorBar extends StatefulWidget {
  /// Callback function used to set the background of the widget container
  final Function(int) set;

  NavigatorBar(this.set, {Key key}) : super(key: key);

  @override
  NavigatorBarState createState() => NavigatorBarState();
}

class NavigatorBarState extends State<NavigatorBar> {
  /// Colour of the tab on the navigator and the background of the navigator tab.
  Color color;

  /// The index position of the tab which is currently in an 'opened' state
  int openedTabIndex = 0;
  GlobalKey _currentIndex = GlobalKey();
  double width = 0;

  double _positionFromLeft = -10;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();

//    selectTab(this.widget.apply);
  }

  _afterLayout(_) {
    setState(() {
      width = _currentIndex.currentContext.size.width;

      this._positionFromLeft =
          ((width * (openedTabIndex)) / 3.0) + width / 6.0 - 2.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: Stack(
            children: [
              Padding(
                key: _currentIndex,
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    NavigatorElement(
                      icon: EvaIcons.radioButtonOffOutline,
                      select: selectTab,
                      position: 0,
                      isOpened: openedTabIndex == 0,
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).disabledColor,
                    ),
                    NavigatorElement(
                      icon: EvaIcons.messageSquareOutline,
                      select: selectTab,
                      position: 1,
                      isOpened: openedTabIndex == 1,
                      color: Theme.of(context).primaryColorDark,
                      disabledColor: Theme.of(context).accentColor,
                    ),
                    NavigatorElement(
                      icon: EvaIcons.personOutline,
                      select: selectTab,
                      position: 2,
                      isOpened: openedTabIndex == 2,
                      color: Theme.of(context).primaryColorLight,
                      disabledColor: Theme.of(context).splashColor,
                    )
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                bottom: 17,
                left: _positionFromLeft,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 5.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                      color: openedTabIndex == 0
                          ? Theme.of(context).primaryColor
                          : openedTabIndex == 1
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
              )
            ],
          )),
    );
  }

  selectTab(int tabIndex, {bool callback = true}) {
    print("tabindex selected: $tabIndex");
    setState(() {
      if (callback) widget.set(tabIndex);
      this.color = color;
      this.openedTabIndex = tabIndex;
      this._positionFromLeft =
          ((width * (openedTabIndex)) / 3.0) + width / 6.0 - 2.5;
    });

    print(this._positionFromLeft);
  }
}

class NavigatorElement extends StatefulWidget {
  final IconData icon;
  final bool isOpened;
  final int position;
  final Color color;
  final Color disabledColor;
  final Function(int) select;

  NavigatorElement(
      {this.icon,
      this.isOpened,
      this.position,
      this.select,
      this.color,
      this.disabledColor});

  @override
  _NavigatorElementState createState() => _NavigatorElementState();
}

class _NavigatorElementState extends State<NavigatorElement>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Color get color => widget.isOpened ? widget.color : widget.disabledColor;

  Animatable<Color> background;
  Animatable<double> size;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    widget.isOpened
        ? _controller.animateTo(0.0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic)
        : _controller.animateTo(1.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    background = ColorTween(begin: widget.color, end: widget.disabledColor);

    widget.isOpened
        ? _controller.animateTo(0.0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic)
        : _controller.animateTo(1.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20.0),
      child: IconButton(
        enableFeedback: false,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashRadius: 50.0,

        icon: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Align(
              alignment: Alignment.center,
              child: Icon(
                widget.icon,
                color: background?.evaluate(
                  AlwaysStoppedAnimation(_controller.value),
                ),
              ),
            );
          },
        ),
        onPressed: () {
          widget.isOpened
              ? _controller.animateTo(0.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic)
              : _controller.animateTo(1.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic);
          widget.select(widget.position);
        },
      ),
    );
  }
}

//() {
//        widget.isOpened
//            ? _controller.animateTo(0.0,
//                duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic)
//            : _controller.animateTo(1.0,
//                duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
//        widget.select(widget.position);
//      },

//AnimatedBuilder(
//        animation: _controller,
//        builder: (BuildContext context, Widget child) {
//          return Align(
//            alignment: Alignment.center,
//            child: Icon(
//              widget.icon,
//              color: background?.evaluate(
//                AlwaysStoppedAnimation(_controller.value),
//              ),
//            ),
//          );
//        },
//      )
