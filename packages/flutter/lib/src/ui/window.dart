part of flur.ui;

/// Signature of callbacks that have no arguments and return no data.
typedef void VoidCallback();

/// Signature for [Window.onBeginFrame].
typedef void FrameCallback(Duration duration);

/// Signature for [Window.onPointerDataPacket].
typedef void PointerDataPacketCallback(PointerDataPacket packet);

/// Signature for [Window.onSemanticsAction].
typedef void SemanticsActionCallback(int id, SemanticsAction action);

/// Signature for responses to platform messages.
///
/// Used as a parameter to [Window.sendPlatformMessage] and
/// [Window.onPlatformMessage].
typedef void PlatformMessageResponseCallback(ByteData data);

/// Signature for [Window.onPlatformMessage].
typedef void PlatformMessageCallback(String name, ByteData data,
    PlatformMessageResponseCallback callback);

/// States that an application can be in.
///
/// The values below describe notifications from the operating system.
/// Applications should not expect to always receive all possible
/// notifications. For example, if the users pulls out the battery from the
/// device, no notification will be sent before the application is suddenly
/// terminated, along with the rest of the operating system.
///
/// See also:
///
///  * [WidgetsBindingObserver], for a mechanism to observe the lifecycle state
///    from the widgets layer.
enum AppLifecycleState {
  /// The application is visible and responding to user input.
  resumed,

  /// The application is in an inactive state and is not receiving user input.
  ///
  /// On iOS, this state corresponds to an app or the Flutter host view running
  /// in the foreground inactive state. Apps transition to this state when in
  /// a phone call, responding to a TouchID request, when entering the app
  /// switcher or the control center, or when the UIViewController hosting the
  /// Flutter app is transitioning. Apps in this state should assume that they
  /// may be [paused] at any time.
  ///
  /// On Android, this state is currently unused.
  inactive,

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  ///
  /// When the application is in this state, the engine will not call the
  /// [Window.onBeginFrame] and [Window.onDrawFrame] callbacks.
  ///
  /// Android apps in this state should assume that they may enter the
  /// [suspending] state at any time.
  paused,

  /// The application will be suspended momentarily.
  ///
  /// When the application is in this state, the engine will not call the
  /// [Window.onBeginFrame] and [Window.onDrawFrame] callbacks.
  ///
  /// On iOS, this state is currently unused.
  suspending,
}

/// A representation of distances for each of the four edges of a rectangle,
/// used to encode the padding that applications should place around their user
/// interface, as exposed by [Window.padding].
///
/// For a generic class that represents distances around a rectangle, see the
/// [EdgeInsets] class.
///
/// See also:
///
///  * [WidgetsBindingObserver], for a widgets layer mechanism to receive
///    notifications when the padding changes.
///  * [MediaQuery.of], a simpler mechanism for the same.
///  * [Scaffold], which automatically applies the padding in material design
///    applications.
class WindowPadding {
  const WindowPadding._({this.left, this.top, this.right, this.bottom});

  /// The distance from the left edge to the first unobscured pixel, in physical pixels.
  final double left;

  /// The distance from the top edge to the first unobscured pixel, in physical pixels.
  final double top;

  /// The distance from the right edge to the first unobscured pixel, in physical pixels.
  final double right;

  /// The distance from the bottom edge to the first unobscured pixel, in physical pixels.
  final double bottom;

  /// A window padding that has zeros for each edge.
  static const WindowPadding zero =
  const WindowPadding._(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0);
}

/// An identifier used to select a user's language and formatting preferences,
/// consisting of a language and a country. This is a subset of locale
/// identifiers as defined by BCP 47.
///
/// See also:
///
///  * [Window.locale], which specifies the system's currently selected
///    [Locale].
class Locale {
  /// Creates a new Locale object. The first argument is the
  /// primary language subtag, the second is the region subtag.
  ///
  /// For example:
  ///
  /// ```dart
  /// const Locale swissFrench = const Locale('fr', 'CH');
  /// const Locale canadianFrench = const Locale('fr', 'CA');
  /// ```
  const Locale(this.languageCode, this.countryCode);

  /// The primary language subtag for the locale.
  final String languageCode;

  /// The region subtag for the locale.
  final String countryCode;

  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! Locale) return false;
    final Locale typedOther = other;
    return languageCode == typedOther.languageCode &&
        countryCode == typedOther.countryCode;
  }

  int get hashCode {
    int result = 373;
    result = 37 * result + languageCode.hashCode;
    result = 37 * result + countryCode.hashCode;
    return result;
  }

  String toString() => '${languageCode}_$countryCode';
}

/// The most basic interface to the host operating system's user interface.
///
/// There is a single Window instance in the system, which you can
/// obtain from the [window] property.
class Window {
  Window._();

  /// The number of device pixels for each logical pixel. This number might not
  /// be a power of two. Indeed, it might not even be an integer. For example,
  /// the Nexus 6 has a device pixel ratio of 3.5.
  ///
  /// Device pixels are also referred to as physical pixels. Logical pixels are
  /// also referred to as device-independent or resolution-independent pixels.
  ///
  /// By definition, there are roughly 38 logical pixels per centimeter, or
  /// about 96 logical pixels per inch, of the physical display. The value
  /// returned by [devicePixelRatio] is ultimately obtained either from the
  /// hardware itself, the device drivers, or a hard-coded value stored in the
  /// operating system or firmware, and may be inaccurate, sometimes by a
  /// significant margin.
  ///
  /// The Flutter framework operates in logical pixels, so it is rarely
  /// necessary to directly deal with this property.
  ///
  /// See also:
  ///
  ///  * [WidgetsBindingObserver], for a mechanism at the widgets layer to
  ///    observe when this value changes.
  double get devicePixelRatio => _devicePixelRatio;
  double _devicePixelRatio = 1.0;

  /// The dimensions of the rectangle into which the application will be drawn,
  /// in physical pixels.
  ///
  /// See also:
  ///
  ///  * [WidgetsBindingObserver], for a mechanism at the widgets layer to
  ///    observe when this value changes.
  Size get physicalSize => _physicalSize;
  Size _physicalSize = Size.zero;

  /// The number of physical pixels on each side of the display rectangle into
  /// which the application can render, but over which the operating system will
  /// likely place system UI (such as the Android system notification area), or
  /// which might be rendered outside of the physical display (e.g. overscan
  /// regions on television screens).
  ///
  /// See also:
  ///
  ///  * [WidgetsBindingObserver], for a mechanism at the widgets layer to
  ///    observe when this value changes.
  ///  * [MediaQuery.of], a simpler mechanism for the same.
  ///  * [Scaffold], which automatically applies the padding in material design
  ///    applications.
  WindowPadding get padding => _padding;
  WindowPadding _padding = WindowPadding.zero;

  /// A callback that is invoked whenever the [devicePixelRatio],
  /// [physicalSize], or [padding] values change, for example when the device is
  /// rotated or when the application is resized (e.g. when showing applications
  /// side-by-side on Android).
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  VoidCallback get onMetricsChanged => _onMetricsChanged;
  VoidCallback _onMetricsChanged;

  set onMetricsChanged(VoidCallback callback) {
    _onMetricsChanged = callback;
  }

  /// The system-reported locale.
  ///
  /// This establishes the language and formatting conventions that application
  /// should, if possible, use to render their user interface.
  ///
  /// The [onLocaleChanged] callback is called whenever this value changes.
  ///
  /// See also:
  ///
  ///  * [WidgetsBindingObserver], for a mechanism at the widgets layer to
  ///    observe when this value changes.
  Locale get locale => _locale;
  Locale _locale;

  /// A callback that is invoked whenever [locale] changes value.
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  ///
  /// See also:
  ///
  ///  * [WidgetsBindingObserver], for a mechanism at the widgets layer to
  ///    observe when this callback is invoked.
  VoidCallback get onLocaleChanged => _onLocaleChanged;
  VoidCallback _onLocaleChanged;

  set onLocaleChanged(VoidCallback callback) {
    _onLocaleChanged = callback;
  }

  /// A callback that is invoked to notify the application that it is an
  /// appropriate time to provide a scene using the [SceneBuilder] API and the
  /// [render] method. When possible, this is driven by the hardware VSync
  /// signal. This is only called if [scheduleFrame] has been called since the
  /// last time this callback was invoked.
  ///
  /// The [onDrawFrame] callback is invoked immediately after [onBeginFrame],
  /// after draining any microtasks (e.g. completions of any [Future]s) queued
  /// by the [onBeginFrame] handler.
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  ///
  /// See also:
  ///
  ///  * [SchedulerBinding], the Flutter framework class which manages the
  ///    scheduling of frames.
  ///  * [RendererBinding], the Flutter framework class which manages layout and
  ///    painting.
  FrameCallback get onBeginFrame => _onBeginFrame;
  FrameCallback _onBeginFrame;

  set onBeginFrame(FrameCallback callback) {
    _onBeginFrame = callback;
  }

  /// A callback that is invoked for each frame after [onBeginFrame] has
  /// completed and after the microtask queue has been drained. This can be
  /// used to implement a second phase of frame rendering that happens
  /// after any deferred work queued by the [onBeginFrame] phase.
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  ///
  /// See also:
  ///
  ///  * [SchedulerBinding], the Flutter framework class which manages the
  ///    scheduling of frames.
  ///  * [RendererBinding], the Flutter framework class which manages layout and
  ///    painting.
  VoidCallback get onDrawFrame => _onDrawFrame;
  VoidCallback _onDrawFrame;

  set onDrawFrame(VoidCallback callback) {
    _onDrawFrame = callback;
  }

  /// A callback that is invoked when pointer data is available.
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  ///
  /// See also:
  ///
  ///  * [GestureBinding], the Flutter framework class which manages pointer
  ///    events.
  PointerDataPacketCallback get onPointerDataPacket => _onPointerDataPacket;
  PointerDataPacketCallback _onPointerDataPacket;

  set onPointerDataPacket(PointerDataPacketCallback callback) {
    _onPointerDataPacket = callback;
  }

  /// The route or path that the operating system requested when the application
  /// was launched.
  String get defaultRouteName => _defaultRouteName();

  String _defaultRouteName() {
    return null;
  }

  /// Requests that, at the next appropriate opportunity, the [onBeginFrame]
  /// and [onDrawFrame] callbacks be invoked.
  ///
  /// See also:
  ///
  ///  * [SchedulerBinding], the Flutter framework class which manages the
  ///    scheduling of frames.
  void scheduleFrame() {}

  /// Whether the user has requested that [updateSemantics] be called when
  /// the semantic contents of window changes.
  ///
  /// The [onSemanticsEnabledChanged] callback is called whenever this value
  /// changes.
  bool get semanticsEnabled => _semanticsEnabled;
  bool _semanticsEnabled = false;

  /// A callback that is invoked when the value of [semanticsEnabled] changes.
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  VoidCallback get onSemanticsEnabledChanged => _onSemanticsEnabledChanged;
  VoidCallback _onSemanticsEnabledChanged;

  set onSemanticsEnabledChanged(VoidCallback callback) {
    _onSemanticsEnabledChanged = callback;
  }

  /// A callback that is invoked whenever the user requests an action to be
  /// performed.
  ///
  /// This callback is used when the user expresses the action they wish to
  /// perform based on the semantics supplied by [updateSemantics].
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  SemanticsActionCallback get onSemanticsAction => _onSemanticsAction;
  SemanticsActionCallback _onSemanticsAction;

  set onSemanticsAction(SemanticsActionCallback callback) {
    _onSemanticsAction = callback;
  }

  /// Change the retained semantics data about this window.
  ///
  /// If [semanticsEnabled] is true, the user has requested that this funciton
  /// be called whenever the semantic content of this window changes.
  ///
  /// In either case, this function disposes the given update, which means the
  /// semantics update cannot be used further.
  void updateSemantics(SemanticsUpdate update) {}

  /// Sends a message to a platform-specific plugin.
  ///
  /// The `name` parameter determines which plugin receives the message. The
  /// `data` parameter contains the message payload and is typically UTF-8
  /// encoded JSON but can be arbitrary data. If the plugin replies to the
  /// message, `callback` will be called with the response.
  ///
  /// The framework invokes [callback] in the same zone in which this method
  /// was called.
  void sendPlatformMessage(String name, ByteData data,
      PlatformMessageResponseCallback callback) {
    _sendPlatformMessage(
        name, _zonedPlatformMessageResponseCallback(callback), data);
  }

  void _sendPlatformMessage(String name,
      PlatformMessageResponseCallback callback, ByteData data) {
    flur.PlatformPlugin.current.sendPlatformMessage(name, callback, data);
  }

  /// Called whenever this window receives a message from a platform-specific
  /// plugin.
  ///
  /// The `name` parameter determines which plugin sent the message. The `data`
  /// parameter is the payload and is typically UTF-8 encoded JSON but can be
  /// arbitrary data.
  ///
  /// Message handlers must call the function given in the `callback` parameter.
  /// If the handler does not need to respond, the handler should pass `null` to
  /// the callback.
  ///
  /// The framework invokes this callback in the same zone in which the
  /// callback was set.
  PlatformMessageCallback get onPlatformMessage => _onPlatformMessage;
  PlatformMessageCallback _onPlatformMessage;

  set onPlatformMessage(PlatformMessageCallback callback) {
    _onPlatformMessage = callback;
  }

  /// Wraps the given [callback] in another callback that ensures that the
  /// original callback is called in the zone it was registered in.
  static PlatformMessageResponseCallback _zonedPlatformMessageResponseCallback(
      PlatformMessageResponseCallback callback) {
    if (callback == null) return null;

    // Store the zone in which the callback is being registered.
    final Zone registrationZone = Zone.current;

    return (ByteData data) {
      registrationZone.runUnaryGuarded(callback, data);
    };
  }
}

/// The [Window] singleton. This object exposes the size of the display, the
/// core scheduler API, the input event callback, the graphics drawing API, and
/// other such core services.
final Window window = new Window._();