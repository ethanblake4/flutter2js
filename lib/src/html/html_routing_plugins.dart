import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/widgets.dart';
import 'package:flutter2js/core.dart';

class UrlFragmentRoutingPlugin extends RoutingPlugin {
  @override
  String get current {
    var value = html.window.location.hash;

    // Remove hash
    if (value.startsWith("#")) value = value.substring(1);

    // Handle special cases
    if (value == "") {
      return Navigator.defaultRouteName;
    }
    print("Route is: ${value}");

    // Return route
    return value;
  }

  @override
  Stream<String> get stream => html.window.onHashChange.map((event) => current);

  @override
  void assign(String value) {
    html.window.location.hash = value;
  }

  @override
  void push(String value) {
    html.window.location.hash = value;
  }
}

class UrlPathRoutingPlugin extends RoutingPlugin {
  final String prefix;

  final StreamController<String> _streamController =
      new StreamController<String>();

  UrlPathRoutingPlugin({this.prefix: ""}) {
    html.window.onPopState.listen((event) {
      assign(current);
    });
  }

  @override
  String get current {
    var value = html.window.history.state as String;

    // Handle special cases
    if (value == null || value == "") {
      return Navigator.defaultRouteName;
    }

    // Remove prefix
    if (value.startsWith(prefix)) {
      value = value.substring(prefix.length);
    }
    return value;
  }

  @override
  Stream<String> get stream => _streamController.stream;

  @override
  void assign(String value) {
    // Fire an event
    _streamController.add(value);

    // Replace state
    value = "${prefix}${value}";
    html.window.history.replaceState(value, "", value);
  }

  @override
  void push(String value) {
    // Fire an event
    _streamController.add(value);

    // Push state
    value = "${prefix}${value}";
    html.window.history.pushState(value, "", value);
  }
}
