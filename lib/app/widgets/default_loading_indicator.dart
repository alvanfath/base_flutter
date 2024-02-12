import 'package:flutter/material.dart';

class DefaultLoadingIndicator extends StatelessWidget {
  const DefaultLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
