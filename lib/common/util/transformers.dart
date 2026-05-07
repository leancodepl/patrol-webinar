import 'dart:async';

StreamTransformer<S, T> errorToData<S, T>(T returnValue) {
  return StreamTransformer<S, T>.fromHandlers(
    handleError: (_, _, sink) => sink.add(returnValue),
  );
}
