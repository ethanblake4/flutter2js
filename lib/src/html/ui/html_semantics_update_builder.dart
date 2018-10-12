import 'dart:typed_data';

import 'package:flutter/ui.dart';

import '../logging.dart';

class HtmlSemanticsUpdate extends SemanticsUpdate {
  @override
  void dispose() {}
}

class HtmlSemanticsUpdateBuilder extends Object with HasDebugName implements SemanticsUpdateBuilder {
  final String debugName;

  HtmlSemanticsUpdateBuilder() : this.debugName = allocateDebugName( "SemanticsUpdateBuilder") {
    logConstructor(this);
  }

  @override
  SemanticsUpdate build() {
    logMethod(this, "build");
    return new HtmlSemanticsUpdate();
  }


  @override
  void updateCustomAction({int id, String label, String hint, int overrideId = -1}) {

  }

  @override
  void updateNode({int id, int flags, int actions, int textSelectionBase,
    int textSelectionExtent, int scrollChildren, int scrollIndex,
    double scrollPosition, double scrollExtentMax, double scrollExtentMin,
    Rect rect, String label, String hint, String value, String increasedValue,
    String decreasedValue, TextDirection textDirection, Float64List transform,
    Int32List childrenInTraversalOrder, Int32List childrenInHitTestOrder,
    Int32List customAcccessibilityActions, Int32List additionalActions}) {

  }
}
