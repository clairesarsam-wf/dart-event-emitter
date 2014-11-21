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

  events.once("boom", handler);
  events.emit("boom", "some data");
  print("should have called handler.");

  events.emit("boom", "some data");
  print("should not have called handler.");
}