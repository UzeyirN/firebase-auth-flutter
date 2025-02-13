void anyFunc(int number) {
  if (number < 100) {
    print(number);
  } else {
    throw Exception('Another type error');
  }
}

void intermediateFunc(int num) {
  try {
    anyFunc(num);
  } catch (e) {
    print('inter func catch this error: $e');
    rethrow;
  }
}

class ExceptionTypeA implements Exception {}

class ExceptionTypeB implements Exception {}

main() {
  try {
    intermediateFunc(1000);
  } catch (e) {
    print('Main func catch this error: $e');
  }
}
