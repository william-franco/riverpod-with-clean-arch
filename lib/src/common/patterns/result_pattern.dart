sealed class Result<S, E extends Exception> {
  const Result();

  T fold<T>({
    required T Function(S value) onSuccess,
    required T Function(E error) onError,
  }) {
    switch (this) {
      case SuccessResult(value: final v):
        return onSuccess(v);
      case ErrorResult(error: final e):
        return onError(e);
    }
  }
}

final class SuccessResult<S, E extends Exception> extends Result<S, E> {
  final S value;

  const SuccessResult({required this.value});
}

final class ErrorResult<S, E extends Exception> extends Result<S, E> {
  final E error;

  const ErrorResult({required this.error});
}
