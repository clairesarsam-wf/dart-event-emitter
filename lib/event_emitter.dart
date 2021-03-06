library event_emitter;

class EventEmitter {

  /**
   * Mapping of events to a list of event handlers
   */
  Map<String, List<Function>> listeners = new Map<String, List<Function>>();

  /**
   * Mapping of events to a list of one-time event handlers
   */
  Map<String, List<Function>> listenersOnce = new Map<String, List<Function>>();

  /**
   * This function triggers all the handlers currently listening
   * to `event` and passes them `data`.
   *
   * @param String event - The event to trigger
   * @param dynamic data - The data to send to each handler
   * @return void
   */
  void emit(String event, [dynamic data]) {
    _getHandlers(this.listeners, event).forEach((Function handler) {
      data != null ? handler(data) : handler();
    });
    _getHandlers(this.listenersOnce, event).forEach((Function handler) {
      data != null ? handler(data) : handler();
      off(event, handler);
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
    this.listeners.putIfAbsent(event, () => new List<Function>());
    this._getHandlers(this.listeners, event).add(handler);
  }

  /**
   * This function binds the `handler` as a listener to the first
   * occurrence of the `event`. When `handler` is called once,
   * it is removed.
   *
   * @param String event     - The event to add the handler to
   * @param Function handler - The handler to bind to the event
   * @return void
   */
  void once(String event, Function handler) {
    this.listenersOnce.putIfAbsent(event, () => new List<Function>());
    _getHandlers(this.listenersOnce, event).add(handler);
  }

  /**
   * This function attempts to unbind the `handler` from the `event`
   *
   * @param String event     - The event to remove the handler from
   * @param Function handler - The handler to remove
   * @return void
   */
  void off(String event, Function handler) {
    this.listeners[event] = _getHandlers(this.listeners, event).where((h) => h != handler).toList();
    this.listenersOnce[event] = _getHandlers(this.listenersOnce, event).where((h) => h != handler).toList();
  }

  /**
   * This function unbinds all the handlers for all the events
   *
   * @return void
   */
  void clearListeners() {
    this.listeners = new Map<String, List<Function>>();
    this.listenersOnce = new Map<String, List<Function>>();
  }

  /**
   * This utility function returns list of handlers for an event
   *
   * @param Map <String, List<Function>> events - the map to retrieve the handlers from
   * @param String event - the event to retrieve the handlers for
   * @return List<Function>
   */
  List<Function> _getHandlers(Map <String, List<Function>> events, String event) {
    if (events.containsKey(event)) {
      return events[event];
    }
    return new List<Function>();
  }
}