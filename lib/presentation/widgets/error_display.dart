import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;

  const ErrorDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectableText.rich(
        TextSpan(
          text: 'Error: ',
          style: const TextStyle(color: Colors.red),
          children: [TextSpan(text: message)],
        ),
      ),
    );
  }
}
