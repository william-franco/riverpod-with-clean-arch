sealed class AppState<S, E extends Exception> {
  const AppState();
}

final class InitialState<S, E extends Exception> extends AppState<S, E> {
  const InitialState();
}

final class LoadingState<S, E extends Exception> extends AppState<S, E> {
  const LoadingState();
}

final class SuccessState<S, E extends Exception> extends AppState<S, E> {
  final S data;

  const SuccessState({required this.data});
}

final class ErrorState<S, E extends Exception> extends AppState<S, E> {
  final E error;

  const ErrorState({required this.error});
}
