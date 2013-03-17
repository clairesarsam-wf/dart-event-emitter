Event Emitter
=============
An event emitter implementation. Good for loose coupling of components.

Examples
--------
```dart
import 'package:event_emitter/event_emitter.dart';

main() {

  var events  = new EventEmitter();
  var handler = (v) => print("*** called handler");

  events.emit("boom", "some data");
  print("should not have called handler.");

  events.on("boom", handler);
  events.emit("boom", "some data");
  print("should have called handler.");

  events.off("boom", handler);
  events.emit("boom", "some data");
  print("should not have called handler.");

  events.on("boom", handler);
  events.clearListeners();
  events.emit("boom", "some data");
  print("should not have called handler.");

}
```

Public Interface
----------------
```dart
library event_emitter;

import 'package:dictionary/dictionary.dart';

class EventEmitter {

  /**
   * Typical constructor
   */
  EventEmitter();

  /**
   * This function triggers all the handlers currently listening
   * to `event` and passes them `data`.
   *
   * @param {String} event - The event to trigger
   * @param {dynamic} data - The data to send to each handler
   * @return {void}
   */
  void emit(String event, dynamic data);

  /**
   * This function binds the `handler` as a listener to the `event`
   *
   * @param {String} event     - The event to add the handler to
   * @param {Function} handler - The handler to bind to the event
   * @return {void}
   */
  void on(String event, Function handler);

  /**
   * This function attempts to unbind the `handler` fromt the `event`
   *
   * @param {String} event     - The event to remove the handler from
   * @param {Function} handler - The handler to remove
   * @return {void}
   */
  void off(String event, Function handler);

  /**
   * This function unbinds all the handlers for all the events
   *
   * @return {void}
   */
  void clearListeners();

}
```