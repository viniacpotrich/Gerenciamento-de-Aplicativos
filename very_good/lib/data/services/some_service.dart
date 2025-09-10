// A simple service that we can listen to

import 'dart:async';

class SomeService {
  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;

  void addData(String data) {
    _controller.add(data);
  }
}
