import 'package:flutter/material.dart';
import 'package:riverpod_with_clean_arch/src/common/extensions/platform_extension.dart';

typedef OnRefreshCallback = Future<void> Function();

class RefreshIndicatorWidget extends StatelessWidget {
  final Widget child;
  final OnRefreshCallback onRefresh;

  const RefreshIndicatorWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return context.isWeb
        ? child
        : RefreshIndicator(onRefresh: onRefresh, child: child);
  }
}
