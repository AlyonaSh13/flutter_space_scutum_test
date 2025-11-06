import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/widget/scaffold_widget.dart';

/// Page displayed when the router cannot find a matching route.
///
/// Typical scenarios:
/// - invalid URL
/// - incorrect navigation path
/// - missing route configuration
///
/// This page simply shows a loading spinner styled in orange.
/// In production, it could be replaced with:
/// - a custom 404 page
/// - a retry button
/// - a redirect to the home screen
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      body: Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
    );
  }
}
