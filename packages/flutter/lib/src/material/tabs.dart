// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flur/flur_for_modified_flutter.dart' as flur;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'app_bar.dart';
import 'colors.dart';
import 'material.dart';
import 'tab_controller.dart';
import 'theme.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;
const double _kMinTabWidth = 72.0;
const double _kMaxTabWidth = 264.0;

/// A material design [TabBar] tab. If both [icon] and [text] are
/// provided, the text is displayed below the icon.
///
/// See also:
///
///  * [TabBar], which displays a row of tabs.
///  * [TabBarView], which displays a widget for the currently selected tab.
///  * [TabController], which coordinates tab selection between a [TabBar] and a [TabBarView].
///  * <https://material.google.com/components/tabs.html>
class Tab extends flur.StatelessUIPluginWidget {
  /// Creates a material design [TabBar] tab. At least one of [text] and [icon]
  /// must be non-null.
  const Tab({
    Key key,
    this.text,
    this.icon,
  })
      : super(key: key);

  /// The text to display as the tab's label.
  final String text;

  /// An icon to display as the tab's label.
  final Widget icon;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(new StringProperty('text', text, defaultValue: null));
    description
        .add(new DiagnosticsProperty<Widget>('icon', icon, defaultValue: null));
  }

  @override
  Widget buildWithUIPlugin(BuildContext context, flur.UIPlugin plugin) {
    return plugin.buildTab(context, this);
  }
}

/// A material design widget that displays a horizontal row of tabs.
///
/// Typically created as the [AppBar.bottom] part of an [AppBar] and in
/// conjuction with a [TabBarView].
///
/// If a [TabController] is not provided, then there must be a
/// [DefaultTabController] ancestor. The tab controller's [TabController.length]
/// must equal the length of the [tabs] list.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [TabBarView], which displays page views that correspond to each tab.
class TabBar extends flur.StatelessUIPluginWidget
    implements PreferredSizeWidget {
  /// Creates a material design tab bar.
  ///
  /// The [tabs] argument must not be null and its length must match the [controller]'s
  /// [TabController.length].
  ///
  /// If a [TabController] is not provided, then there must be a
  /// [DefaultTabController] ancestor.
  ///
  /// The [indicatorWeight] parameter defaults to 2, and must not be null.
  ///
  /// The [indicatorPadding] parameter defaults to [EdgeInsets.zero], and must not be null.
  TabBar({
    Key key,
    @required this.tabs,
    this.controller,
    this.isScrollable: false,
    this.indicatorColor,
    this.indicatorWeight: 2.0,
    this.indicatorPadding: EdgeInsets.zero,
    this.labelColor,
    this.labelStyle,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
  })
      : super(key: key);

  /// Typically a list of two or more [Tab] widgets.
  ///
  /// The length of this list must match the [controller]'s [TabController.length].
  final List<Widget> tabs;

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController controller;

  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [isScrollable] is true then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isScrollable;

  /// The color of the line that appears below the selected tab. If this parameter
  /// is null then the value of the Theme's indicatorColor property is used.
  final Color indicatorColor;

  /// The thickness of the line that appears below the selected tab. The value
  /// of this parameter must be greater than zero.
  ///
  /// The default value of [indicatorWeight] is 2.0.
  final double indicatorWeight;

  /// The horizontal padding for the line that appears below the selected tab.
  /// For [isScrollable] tab bars, specifying [kTabLabelPadding] will align
  /// the indicator with the tab's text for [Tab] widgets and all but the
  /// shortest [Tab.text] values.
  ///
  /// The [EdgeInsets.top] and [EdgeInsets.bottom] values of the
  /// [indicatorPadding] are ignored.
  ///
  /// The default value of [indicatorPadding] is [EdgeInsets.zero].
  final EdgeInsets indicatorPadding;

  /// The color of selected tab labels.
  ///
  /// Unselected tab labels are rendered with the same color rendered at 70%
  /// opacity unless [unselectedLabelColor] is non-null.
  ///
  /// If this parameter is null then the color of the theme's body2 text color
  /// is used.
  final Color labelColor;

  /// The color of unselected tab labels.
  ///
  /// If this property is null, Unselected tab labels are rendered with the
  /// [labelColor] rendered at 70% opacity.
  final Color unselectedLabelColor;

  /// The text style of the selected tab labels. If [unselectedLabelStyle] is
  /// null then this text style will be used for both selected and unselected
  /// label styles.
  ///
  /// If this property is null then the text style of the theme's body2
  /// definition is used.
  final TextStyle labelStyle;

  /// The text style of the unselected tab labels
  ///
  /// If this property is null then the [labelStyle] value is used. If [labelStyle]
  /// is null then the text style of the theme's body2 definition is used.
  final TextStyle unselectedLabelStyle;

  /// A size whose height depends on if the tabs have both icons and text.
  ///
  /// [AppBar] uses this this size to compute its own preferred size.
  @override
  Size get preferredSize {
    for (Widget item in tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if (tab.text != null && tab.icon != null)
          return new Size.fromHeight(_kTextAndIconTabHeight + indicatorWeight);
      }
    }
    return new Size.fromHeight(_kTabHeight + indicatorWeight);
  }

  @override
  Widget buildWithUIPlugin(BuildContext context, flur.UIPlugin plugin) {
    return plugin.buildTabBar(context, this);
  }
}

/// A page view that displays the widget which corresponds to the currently
/// selected tab. Typically used in conjuction with a [TabBar].
///
/// If a [TabController] is not provided, then there must be a [DefaultTabController]
/// ancestor.
class TabBarView extends flur.StatelessUIPluginWidget {
  /// Creates a page view with one child per tab.
  ///
  /// The length of [children] must be the same as the [controller]'s length.
  TabBarView({
    Key key,
    @required this.children,
    this.controller,
    this.physics,
  })
      : super(key: key);

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController controller;

  /// One widget per tab.
  final List<Widget> children;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics physics;

  @override
  Widget buildWithUIPlugin(BuildContext context, flur.UIPlugin plugin) {
    return plugin.buildTabBarView(context, this);
  }
}

/// Displays a single circle with the specified border and background colors.
///
/// Used by [TabPageSelector] to indicate the selected page.
class TabPageSelectorIndicator extends StatelessWidget {
  /// Creates an indicator used by [TabPageSelector].
  ///
  /// The [backgroundColor], [borderColor], and [size] parameters must not be null.
  const TabPageSelectorIndicator({
    Key key,
    @required this.backgroundColor,
    @required this.borderColor,
    @required this.size,
  })
      : super(key: key);

  /// The indicator circle's background color.
  final Color backgroundColor;

  /// The indicator circle's border color.
  final Color borderColor;

  /// The indicator circle's diameter.
  final double size;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(4.0),
      decoration: new BoxDecoration(
        color: backgroundColor,
        border: new Border.all(color: borderColor),
        shape: BoxShape.circle,
      ),
    );
  }
}

double _indexChangeProgress(TabController controller) {
  final double controllerValue = controller.animation.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();

  // The controller's offset is changing because the user is dragging the
  // TabBarView's PageView to the left or right.
  if (!controller.indexIsChanging)
    return (currentIndex -  controllerValue).abs().clamp(0.0, 1.0);

  // The TabController animation's value is changing from previousIndex to currentIndex.
  return (controllerValue - currentIndex).abs() / (currentIndex - previousIndex).abs();
}

/// Displays a row of small circular indicators, one per tab. The selected
/// tab's indicator is highlighted. Often used in conjuction with a [TabBarView].
///
/// If a [TabController] is not provided, then there must be a [DefaultTabController]
/// ancestor.
class TabPageSelector extends StatelessWidget {
  /// Creates a compact widget that indicates which tab has been selected.
  const TabPageSelector({
    Key key,
    this.controller,
    this.indicatorSize: 12.0,
    this.color,
    this.selectedColor,
  }) : super(key: key);

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController controller;

  /// The indicator circle's diameter (the default value is 12.0).
  final double indicatorSize;

  /// The indicator cicle's fill color for unselected pages.
  ///
  /// If this parameter is null then the indicator is filled with [Colors.transparent].
  final Color color;

  /// The indicator cicle's fill color for selected pages and border color
  /// for all indicator circles.
  ///
  /// If this parameter is null then the indicator is filled with the theme's
  /// accent color, [ThemeData.accentColor].
  final Color selectedColor;

  Widget _buildTabIndicator(
      int tabIndex,
      TabController tabController,
      ColorTween selectedColorTween,
      ColorTween previousColorTween,
      ) {
    Color background;
    if (tabController.indexIsChanging) {
      // The selection's animation is animating from previousValue to value.
      final double t = 1.0 - _indexChangeProgress(tabController);
      if (tabController.index == tabIndex)
        background = selectedColorTween.lerp(t);
      else if (tabController.previousIndex == tabIndex)
        background = previousColorTween.lerp(t);
      else
        background = selectedColorTween.begin;
    } else {
      // The selection's offset reflects how far the TabBarView has
      /// been dragged to the left (-1.0 to 0.0) or the right (0.0 to 1.0).
      final double offset = tabController.offset;
      if (tabController.index == tabIndex) {
        background = selectedColorTween.lerp(1.0 - offset.abs());
      } else if (tabController.index == tabIndex - 1 && offset > 0.0) {
        background = selectedColorTween.lerp(offset);
      } else if (tabController.index == tabIndex + 1 && offset < 0.0) {
        background = selectedColorTween.lerp(-offset);
      } else {
        background = selectedColorTween.begin;
      }
    }
    return new TabPageSelectorIndicator(
      backgroundColor: background,
      borderColor: selectedColorTween.end,
      size: indicatorSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color fixColor = color ?? Colors.transparent;
    final Color fixSelectedColor = selectedColor ?? Theme.of(context).accentColor;
    final ColorTween selectedColorTween = new ColorTween(begin: fixColor, end: fixSelectedColor);
    final ColorTween previousColorTween = new ColorTween(begin: fixSelectedColor, end: fixColor);
    final TabController tabController = controller ?? DefaultTabController.of(context);
    assert(() {
      if (tabController == null) {
        throw new FlutterError(
            'No TabController for $runtimeType.\n'
                'When creating a $runtimeType, you must either provide an explicit TabController '
                'using the "controller" property, or you must ensure that there is a '
                'DefaultTabController above the $runtimeType.\n'
                'In this case, there was neither an explicit controller nor a default controller.'
        );
      }
      return true;
    }());
    final Animation<double> animation = new CurvedAnimation(
      parent: tabController.animation,
      curve: Curves.fastOutSlowIn,
    );
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Semantics(
            label: 'Page ${tabController.index + 1} of ${tabController.length}',
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: new List<Widget>.generate(tabController.length, (int tabIndex) {
                return _buildTabIndicator(tabIndex, tabController, selectedColorTween, previousColorTween);
              }).toList(),
            ),
          );
        }
    );
  }
}