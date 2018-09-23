[![Join Gitter Chat Channel -](https://badges.gitter.im/flutter/flutter.svg)](https://gitter.im/flutter/flutter?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Flutter2JS (Revived)
====

Flutter2js was a project that attempted to make [Flutter](https://flutter.io) apps run in browser.
It was abandoned by its old maintainer so I've picked it up as "Flutter2JS" (note caps).

In its current state it does actually work, but only for very simple hello-world level examples.

### Use cases
* Release a browser version of your Flutter app.
* Support devices not supported by Flutter.
* Ease migration between different technologies.

### Design
* Flutter2JS aims to use a combination of DOM elements, CSS, and Canvas API.
* We have defined ways to insert DOM elements in the render tree, including _HtmlCanvas_ (subclass of _dart:ui_ class _Canvas_) methods, _HtmlRenderObject_, and _HtmlWidget_.
* The aim is to optimize performance-critical widgets later (i.e. use HTML elements + CSS styling for them)
* Use a combination of [dartdevc](https://webdev.dartlang.org/tools/dartdevc) for rapid development and [dart2js](https://webdev.dartlang.org/tools/dart2js) for release builds.
* Patched Flutter SDK lives in a separate repository at: [github.com/ethanblake4/flutter2js_packages](https://github.com/flutter2js/flutter2js_packages)
* This repository contains everything else.

## Status
* [X] Contains all Flutter SDK APIs (January 2018).
* [ ] Contains all Flutter SDK APIs (> January 2018)

## Next
* [ ] Flutter SDK examples
  * [ ] Work adequately
  
## Running the example app
Clone this repository into a folder on your computer.

If you have WebStorm, you can simply open the project in examples/hello_world, right click on `index.html` and click Run.

Without WebStorm, you'll have to run the following commands from the hello_world directory (make sure the Dart SDK is in your PATH):
`pub global activate stagehand`
`pub global activate webdev`
`pub global run webdev serve`
  
## Contributing
While contributions at this stage are welcomed, I haven't yet worked out a defined protocol for them, so be reasonable!
