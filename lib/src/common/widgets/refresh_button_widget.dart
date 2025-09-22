import 'package:flutter/material.dart';
import 'package:riverpod_with_clean_arch/src/common/extensions/platform_extension.dart';

@protected
typedef OnPressedCallback = void Function();

class RefreshButtonWidget extends StatelessWidget {
  final OnPressedCallback onPressed;

  const RefreshButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return context.isWeb
        ? IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh_outlined),
          )
        : const SizedBox.shrink();
  }
}
