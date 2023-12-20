import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/custom_widget/custom_curved_edge.dart';

class CurvedEdgesWidget extends StatelessWidget {
  const CurvedEdgesWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: child,
    ); // ClipPath
  }
}
