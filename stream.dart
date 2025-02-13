import 'dart:async';

Stream<int> myStreamFunction() async* {
  for (int i = 0; i < 10; ++i) {
    await Future.delayed(Duration(seconds: 1));

    yield i + 1;
  }
}

main() {
  // myStreamFunction().listen(
  //   (e) {
  //     print('e^2: ${e * e}');
  //   },
  // );

  StreamController myStreamControllerObj = StreamController();
  void functionForStreamController() async {
    for (int i = 0; i < 10; ++i) {
      await Future.delayed(Duration(seconds: 1));
      if (i == 6) {
        myStreamControllerObj.addError('Error found');
      }
      myStreamControllerObj.sink.add(i + 1);
    }
    myStreamControllerObj.close();
  }

  functionForStreamController();

  myStreamControllerObj.stream.listen(
    (e) => print(e * 10),
    onDone: () {
      print('onDone function worked in Stream listener');
    },
    onError: (error) {
      print(error);
    },
    cancelOnError: true,
  );
}
