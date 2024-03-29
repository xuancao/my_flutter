import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


// The over-scroll distance that moves the indicator to its maximum
// displacement, as a percentage of the scrollable's container extent.
const double _kDragContainerExtentPercentage = 0.25;

// How much the scroll's drag gesture can overshoot the RefreshLayout's
// displacement; max displacement = _kDragSizeFactorLimit * displacement.
const double _kDragSizeFactorLimit = 1.5;

// When the scroll ends, the duration of the refresh indicator's animation
// to the RefreshLayout's displacement.
const Duration _kIndicatorSnapDuration = const Duration(milliseconds: 150);

// The duration of the ScaleTransition that starts when the refresh action
// has completed.
const Duration _kIndicatorScaleDuration = const Duration(milliseconds: 200);

/// The signature for a function that's called when the user has dragged a
/// [RefreshLayout] far enough to demonstrate that they want the app to
/// refresh. The returned [Future] must complete when the refresh operation is
/// finished.
///
/// Used by [RefreshLayout.onRefresh].
typedef Future<Null> RefreshCallback(bool refresh);

typedef LoadingWidgeBuilder(BuildContext context);

// The state machine moves through these modes only when the scrollable
// identified by scrollableKey has been scrolled to its min or max limit.
enum _RefreshLayoutMode {
  drag, // Pointer is down.
  armed, // Dragged far enough that an up event will run the onRefresh callback.
  snap, // Animating to the indicator's final "displacement".
  refresh, // Running the refresh callback.
  done, // Animating the indicator's fade-out after refreshing.
  canceled, // Animating the indicator's fade-out after not arming.
}

/// A widget that supports the Material "swipe to refresh" idiom.
///
/// When the child's [Scrollable] descendant overscrolls, an animated circular
/// progress indicator is faded into view. When the scroll ends, if the
/// indicator has been dragged far enough for it to become completely opaque,
/// the [onRefresh] callback is called. The callback is expected to update the
/// scrollable's contents and then complete the [Future] it returns. The refresh
/// indicator disappears after the callback's [Future] has completed.
///
/// If the [Scrollable] might not have enough content to overscroll, consider
/// settings its `physics` property to [AlwaysScrollableScrollPhysics]:
///
/// ```dart
/// new ListView(
///   physics: const AlwaysScrollableScrollPhysics(),
///   children: ...
//  )
/// ```
///
/// Using [AlwaysScrollableScrollPhysics] will ensure that the scroll view is
/// always scrollable and, therefore, can trigger the [RefreshLayout].
///
/// A [RefreshLayout] can only be used with a vertical scroll view.
///
/// See also:
///
///  * <https://material.google.com/patterns/swipe-to-refresh.html>
///  * [RefreshLayoutState], can be used to programmatically show the refresh indicator.
///  * [RefreshProgressIndicator], widget used by [RefreshLayout] to show
///    the inner circular progress spinner during refreshes.
///  * [CupertinoRefreshControl], an iOS equivalent of the pull-to-refresh pattern.
///    Must be used as a sliver inside a [CustomScrollView] instead of wrapping
///    around a [ScrollView] because it's a part of the scrollable instead of
///    being overlaid on top of it.
class RefreshLayout extends StatefulWidget {
  /// Creates a refresh indicator.
  ///
  /// The [onRefresh], [child], and [notificationPredicate] arguments must be
  /// non-null. The default
  /// [displacement] is 40.0 logical pixels.
  const RefreshLayout({
    Key key,
    @required this.child,
    this.canrefresh: true,
    this.canloading: true,
    this.displacement: 20.0,
    @required this.onRefresh,
    this.loadingBuilder,
    this.color,
    this.backgroundColor,
    this.notificationPredicate: defaultScrollNotificationPredicate,
  })
      : assert(child != null),
        assert(onRefresh != null),
        assert(onRefresh != null),
        assert(notificationPredicate != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// The refresh indicator will be stacked on top of this child. The indicator
  /// will appear when child's Scrollable descendant is over-scrolled.
  ///
  /// Typically a [ListView] or [CustomScrollView].
  final Widget child;

  /// The distance from the child's top or bottom edge to where the refresh
  /// indicator will settle. During the drag that exposes the refresh indicator,
  /// its actual displacement may significantly exceed this value.
  final double displacement;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// The progress indicator's foreground color. The current theme's
  /// [ThemeData.accentColor] by default.
  final Color color;

  /// The progress indicator's background color. The current theme's
  /// [ThemeData.canvasColor] by default.
  final Color backgroundColor;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  final LoadingWidgeBuilder loadingBuilder;

  final bool canloading;
  final bool canrefresh;

//  void dissmiss() {
//    if(state!=null)
//    state._dismiss(_RefreshLayoutMode.canceled);
//  }
//
//  void show(bool attop) {
//    if(state!=null)
//    state.show(atTop: attop);
//  }
//
//  void setNomore(bool nomore) {
//    this.nomore = nomore;
//  }


  @override
  RefreshLayoutState createState() => new RefreshLayoutState();
}

/// Contains the state for a [RefreshLayout]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class RefreshLayoutState extends State<RefreshLayout>
    with TickerProviderStateMixin {
  AnimationController _positionController;
  AnimationController _scaleController;
  Animation<double> _positionFactor;
  Animation<double> _scaleFactor;
  Animation<double> _value;
  Animation<Color> _valueColor;

  _RefreshLayoutMode _mode;
  Future<Null> _pendingRefreshFuture;
  bool _isIndicatorAtTop;
  double _dragOffset;

  @override
  void initState() {
    super.initState();

    _positionController = new AnimationController(vsync: this);
    _positionFactor = new Tween<double>(
      begin: 0.0,
      end: _kDragSizeFactorLimit,
    ).animate(_positionController);
    _value = new Tween<
        double>( // The "value" of the circular progress indicator during a drag.
      begin: 0.0,
      end: 0.75,
    ).animate(_positionController);

    _scaleController = new AnimationController(vsync: this);
    _scaleFactor = new Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_scaleController);

    initBuilder();
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _valueColor = new ColorTween(
        begin: (widget.color ?? theme.primaryColor).withOpacity(0.0),
        end: (widget.color ?? theme.primaryColor).withOpacity(1.0)
    ).animate(new CurvedAnimation(
        parent: _positionController,
        curve: const Interval(0.0, 1.0 / _kDragSizeFactorLimit)
    ));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _positionController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }
    if (notification is ScrollStartNotification &&
        notification.metrics.extentBefore == 0.0 &&
        _mode == null && _start(notification.metrics.axisDirection)) {
      setState(() {
        _mode = _RefreshLayoutMode.drag;
      });
      return false;
    }
    bool indicatorAtTopNow;

    switch (notification.metrics.axisDirection) {
      case AxisDirection.down:
        indicatorAtTopNow = true;
        break;
      case AxisDirection.up:
        indicatorAtTopNow = false;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        indicatorAtTopNow = null;
        break;
    }
    if (indicatorAtTopNow != _isIndicatorAtTop) {
      if (_mode == _RefreshLayoutMode.drag ||
          _mode == _RefreshLayoutMode.armed) {
        _dismiss(_RefreshLayoutMode.canceled);
      }
      /**
       * ----------------------------------------
       */
      if (widget.canloading && notification is UserScrollNotification &&
          notification.metrics.extentAfter == 0.0 &&
          notification.direction == ScrollDirection.idle) {
        show(atTop: false);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == _RefreshLayoutMode.drag ||
          _mode == _RefreshLayoutMode.armed) {
        if (notification.metrics.extentBefore > 0.0) {
          _dismiss(_RefreshLayoutMode.canceled);
        } else {
          _dragOffset -= notification.scrollDelta;
          _checkDragOffset(notification.metrics.viewportDimension);
        }
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == _RefreshLayoutMode.drag ||
          _mode == _RefreshLayoutMode.armed) {
        _dragOffset -= notification.overscroll / 2.0;
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    }
    else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case _RefreshLayoutMode.armed:
          if (widget.canrefresh)
            _show();
          break;
        case _RefreshLayoutMode.drag:
          _dismiss(_RefreshLayoutMode.canceled);
          break;
        default:
        // do nothing
          break;
      }
    }
    return false;
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading)
      return false;
    if (_mode == _RefreshLayoutMode.drag) {
      notification.disallowGlow();
      return true;
    }
    return false;
  }

  bool _start(AxisDirection direction) {
    assert(_mode == null);
    assert(_isIndicatorAtTop == null);
    assert(_dragOffset == null);
    switch (direction) {
      case AxisDirection.down:
        _isIndicatorAtTop = true;
        break;
      case AxisDirection.up:
        _isIndicatorAtTop = false;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        _isIndicatorAtTop = null;
        // we do not support horizontal scroll views.
        return false;
    }
    _dragOffset = 0.0;
    _scaleController.value = 0.0;
    _positionController.value = 0.0;
    return true;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_mode == _RefreshLayoutMode.drag ||
        _mode == _RefreshLayoutMode.armed);
    double newValue = _dragOffset /
        (containerExtent * _kDragContainerExtentPercentage);
    if (_mode == _RefreshLayoutMode.armed)
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    _positionController.value =
        newValue.clamp(0.0, 1.0); // this triggers various rebuilds
    if (_mode == _RefreshLayoutMode.drag && _valueColor.value.alpha == 0xFF)
      _mode = _RefreshLayoutMode.armed;
  }

  // Stop showing the refresh indicator.
  Future<Null> _dismiss(_RefreshLayoutMode newMode) async {
    // This can only be called from _show() when refreshing and
    // _handleScrollNotification in response to a ScrollEndNotification or
    // direction change.
    assert(newMode == _RefreshLayoutMode.canceled ||
        newMode == _RefreshLayoutMode.done);
    setState(() {
      _mode = newMode;
    });
    switch (_mode) {
      case _RefreshLayoutMode.done:
        await _scaleController.animateTo(
            1.0, duration: _kIndicatorScaleDuration);
        break;
      case _RefreshLayoutMode.canceled:
        await _positionController.animateTo(
            0.0, duration: _kIndicatorScaleDuration);
        break;
      default:
        assert(false);
    }
    if (mounted && _mode == newMode) {
      _dragOffset = null;
      _isIndicatorAtTop = null;
      setState(() {
        _mode = null;
      });
    }
  }

  void _show() {
    assert(_mode != _RefreshLayoutMode.refresh);
    assert(_mode != _RefreshLayoutMode.snap);
    final Completer<Null> completer = new Completer<Null>();
    _pendingRefreshFuture = completer.future;
    _mode = _RefreshLayoutMode.snap;
    _positionController
        .animateTo(
        1.0 / _kDragSizeFactorLimit, duration: _kIndicatorSnapDuration)
        .then<void>((covariant)
    {
    if (mounted && _mode == _RefreshLayoutMode.snap)
    {
    assert(widget.onRefresh != null);
    setState(() {
    // Show the indeterminate progress indicator.
    _mode = _RefreshLayoutMode.refresh;
    });

    final Future<Null> refreshResult = widget.onRefresh(_isIndicatorAtTop);
    assert(() {
    if (refreshResult == null)
    FlutterError.reportError(new FlutterErrorDetails(
    exception: new FlutterError(
    'The onRefresh callback returned null.\n'
    'The RefreshLayout onRefresh callback must return a Future.'
    ),
    context: 'when calling onRefresh',
    library: 'material library',
    ));
    return true;
    }());
    if (refreshResult == null)
    return;
    refreshResult.whenComplete(() {
    if (mounted && _mode == _RefreshLayoutMode.refresh) {
    completer.complete();
    _dismiss(_isIndicatorAtTop?_RefreshLayoutMode.done:_RefreshLayoutMode.canceled);
    }
    });
    }
    }
    );
  }

  /// Show the refresh indicator and run the refresh callback as if it had
  /// been started interactively. If this method is called while the refresh
  /// callback is running, it quietly does nothing.
  ///
  /// Creating the [RefreshLayout] with a [GlobalKey<RefreshLayoutState>]
  /// makes it possible to refer to the [RefreshLayoutState].
  ///
  /// The future returned from this method completes when the
  /// [RefreshLayout.onRefresh] callback's future completes.
  ///
  /// If you await the future returned by this function from a [State], you
  /// should check that the state is still [mounted] before calling [setState].
  ///
  /// When initiated in this manner, the refresh indicator is independent of any
  /// actual scroll view. It defaults to showing the indicator at the top. To
  /// show it at the bottom, set `atTop` to false.
  Future<Null> show({ bool atTop: true }) {
    if (_mode != _RefreshLayoutMode.refresh &&
        _mode != _RefreshLayoutMode.snap) {
      if (_mode == null)
        _start(atTop ? AxisDirection.down : AxisDirection.up);
      _show();
    }
    return _pendingRefreshFuture;
  }

  final GlobalKey _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Widget child = new NotificationListener<ScrollNotification>(
      key: _key,
      onNotification: _handleScrollNotification,
      child: new NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleGlowNotification,
        child: widget.child,
      ),
    );
    if (_mode == null) {
      assert(_dragOffset == null);
      assert(_isIndicatorAtTop == null);
      return child;
    }
    assert(_dragOffset != null);
    assert(_isIndicatorAtTop != null);

    final bool showIndeterminateIndicator =
        _mode == _RefreshLayoutMode.refresh || _mode == _RefreshLayoutMode.done;

    return new Stack(
      children: <Widget>[
        child,
        new Positioned(
          top: _isIndicatorAtTop ? 0.0 : null,
          bottom: !_isIndicatorAtTop ? 0.0 : null,
          left: 0.0,
          right: 0.0,
          child: new SizeTransition(
            axisAlignment: _isIndicatorAtTop ? 1.0 : -1.0,
            sizeFactor: _positionFactor, // this is what brings it down
            child: new Container(
              padding: _isIndicatorAtTop
                  ? new EdgeInsets.only(top: 50.0)
                  : new EdgeInsets.only(bottom: 0.0),
              alignment: _isIndicatorAtTop
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              child: _isIndicatorAtTop ? (widget.canrefresh
                  ? new ScaleTransition(
                scale: _scaleFactor,
                child: new AnimatedBuilder(
                  animation: _positionController,
                  builder: (BuildContext context, Widget child) {
                    return new RefreshProgressIndicator(
                      value: showIndeterminateIndicator ? null : _value.value,
                      valueColor: _valueColor,
                      backgroundColor: widget.backgroundColor,
                    );
                  },
                ),
              )
                  : null) : new AnimatedBuilder(
                  animation: _positionController,
                  builder: widget.loadingBuilder==null?defaultLoadingBuilder:(context, widge){
                    return widget.loadingBuilder(context);
                  }
              ),
            ),
          ),
        ),
      ],
    );
  }

  TransitionBuilder defaultLoadingBuilder;
  void initBuilder() {
    defaultLoadingBuilder = (BuildContext context, Widget cc) {
      return new Container(decoration: new BoxDecoration(
          gradient: new LinearGradient(begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0x40ffffff),
                Color(0x99ffffff),
                Color(0xBBffffff),
                Color(0xDDffffff),
                Colors.white
              ])),
        child: SizedBox(height: 60.0,
          child: Center(child: new Row(
            mainAxisSize: MainAxisSize.min, children: <Widget>[
            new SizedBox(width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(strokeWidth: 1.3,
                valueColor: _valueColor,
                backgroundColor: widget.backgroundColor,),),
            Padding(padding: EdgeInsets.all(3.0)),
            Text(
              '加载中...     ',
              style: TextStyle(fontSize: 16.0),
            ),
          ],)),),);
    };
  }
}