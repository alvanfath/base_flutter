import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  const DefaultRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  State<DefaultRefreshIndicator> createState() => _DefaultRefreshIndicatorState();
}

class _DefaultRefreshIndicatorState extends State<DefaultRefreshIndicator> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
}
