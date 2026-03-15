import 'package:flutter/material.dart';

abstract class StateManagement<T> extends ChangeNotifier {
  T _state;

  StateManagement(T initialState) : _state = initialState;

  T get state => _state;

  @protected
  void emitState(T newState) {
    if (identical(_state, newState)) return;
    _state = newState;
    debugPrint('StateManagement<$T> -> $newState');
    notifyListeners();
  }

  @override
  String toString() => 'StateManagement<$T>(state: $_state)';
}

@protected
typedef StateBuilder<S> = Widget Function(BuildContext context, S state);

class StateBuilderWidget<V extends StateManagement<S>, S>
    extends StatelessWidget {
  final V viewModel;
  final StateBuilder<S> builder;
  final Widget? child;

  const StateBuilderWidget({
    super.key,
    required this.viewModel,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      child: child,
      builder: (context, child) {
        return builder(context, viewModel.state);
      },
    );
  }
}
