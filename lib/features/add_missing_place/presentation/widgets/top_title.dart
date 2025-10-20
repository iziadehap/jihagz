import 'package:flutter/material.dart';
import 'package:jihagz/core/appCore.dart';

class TopTitle extends StatelessWidget {
  const TopTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    return Column(
      children: [
        Icon(
          Icons.add_location_alt,
          size: 48,
          color: appCore.primaryColor,
        ),
        const SizedBox(height: 12),
        Text(
          'Add Missing Place',
          style: TextStyle(
            color: appCore.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
