import 'package:flutter/material.dart';
import 'package:jihagz/core/appCore.dart';

class ButtonModel extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isStackAllSize;
  const ButtonModel({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isStackAllSize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: isStackAllSize ? null : double.infinity,
            decoration: BoxDecoration(
              color: appCore.primaryColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 36, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
