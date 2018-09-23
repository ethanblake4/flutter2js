import 'dart:html' as html;

import 'package:flutter/ui.dart';

import '../logging.dart';
import 'html_canvas.dart';
import 'html_image.dart';

typedef Command(HtmlCanvas canvas);

class HtmlPicture extends Object with HasDebugName implements Picture {
  final String debugName;
  List<Command> _commands;

  HtmlPicture(this._commands) : this.debugName = allocateDebugName( "Picture") {
    logConstructor(this);
  }

  @override
  void dispose() {
    _commands = null;
  }

  void draw(HtmlCanvas canvas) {
    logMethod(this, "draw", arg0:canvas);
    for (var command in _commands) {
      command(canvas);
    }
  }

  html.CanvasElement toHtmlElement(int width, int height, int widthPx, int heightPx) {
    logMethod(this, "toHtmlElement", arg0:width, arg1:height);
    final element = new html.CanvasElement(width:widthPx, height:heightPx);
    element.setAttribute("data-kind", "Picture");
    element.style.imageRendering = "pixelated";
    element.style.width = "${width}px";
    element.style.height = "${height}px";
    final canvas = new HtmlCanvas(element);
    draw(canvas);
    return element;
  }

  @override
  Image toImage(int width, int height) {
    final dpr = window.devicePixelRatio;
    final element = toHtmlElement(width, height, (width*dpr).toInt(), (width*dpr).toInt());
    return new HtmlEngineImage(element.toDataUrl(), width: (width*dpr).toInt(), height: (height*dpr).toInt());
  }
}

class HtmlPictureRecorder extends Object with HasDebugName implements PictureRecorder {
  final String debugName;
  List<Command> commands = <Command>[];

  HtmlPictureRecorder() : this.debugName = allocateDebugName( "PictureRecorder") {
    logConstructor(this);
  }

  @override
  bool get isRecording {
    return commands != null;
  }

  @override
  Picture endRecording() {
    logMethod(this, "endRecording");
    final commands = this.commands;
    this.commands = null;
    return new HtmlPicture(commands);
  }
}