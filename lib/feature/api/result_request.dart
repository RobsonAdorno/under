sealed class Result<R, E extends Exception> {
  const Result();
}

final class Sucess<S, E extends Exception> extends Result<S, E> {
  final S value;

  const Sucess(this.value);
}

final class Failure<F, E extends Exception> extends Result<F, E> {
  final E exception;

  const Failure(this.exception);
}
