library event_emitter;

import 'package:dictionary/dictionary.dart';

class EventEmitter {

  /**
   * Mapping of events to a list of event handlers
   */
  Dictionary<String, List<Function>> _events;

  /**
   * Typical constructor
   */
  EventEmitter() {
    this._events = new Dictionary<String, List<Function>>();
  }

  /**
   * This function triggers all the handlers currently listening
   * to `event` and passes them `data`.
   *
   * @param String event - The event to trigger
   * @param dynamic data - The data to send to each handler
   * @return void
   */
  void emit(String event, dynamic data) {
    this._events.get(event).map((List<Function> handlers) {
      handlers.forEach((Function handler) {
        handler(data);
      });
    });
  }

  /**
   * This function binds the `handler` as a listener to the `event`
   *
   * @param String event     - The event to add the handler to
   * @param Function handler - The handler to bind to the event
   * @return void
   */
  void on(String event, Function handler) {
    this._events.putIfAbsent(event, () => new List<Function>());
    this._events.get(event).map((List<Function> handlers) {
      handlers.add(handler);
    });
  }

  /**
   * This function attempts to unbind the `handler` from the `event`
   *
   * @param String event     - The event to remove the handler from
   * @param Function handler - The handler to remove
   * @return void
   */
  void off(String event, Function handler) {
    this._events.get(event).map((List<Function> handlers) {
      this._events[event] = handlers.where((h) => h != handler).toList();
    });
  }

  /**
   * This function unbinds all the handlers for all the events
   *
   * @return void
   */
  void clearListeners() {
    this._events = new Dictionary<String, List<Function>>();
  }

}