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
  void _updateNode(
      {int id,
        int flags,
        int actions,
        int textSelectionBase,
        int textSelectionExtent,
        int scrollChildren,
        int scrollIndex,
        double scrollPosition,
        double scrollExtentMax,
        double scrollExtentMin,
        double left,
        double top,
        double right,
        double bottom,
        String label,
        String hint,
        String value,
        String increasedValue,
        String decreasedValue,
        int textDirection,
        Float64List transform,
        Int32List childrenInTraversalOrder,
        Int32List childrenInHitTestOrder,
        Int32List additionalActions}) {}

  @override
  void _updateCustomAction(int id, String label, String hint, int overrideId) {}
}
