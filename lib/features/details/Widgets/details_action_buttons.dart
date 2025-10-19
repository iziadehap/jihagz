import 'package:flutter/material.dart';
import '../controllers/details_controller.dart';
import '../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailsActionButtons extends StatelessWidget {
  final DetailsController controller;
  const DetailsActionButtons({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appCore.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: book now
                },
                child: Text('Book Now', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appCore.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: add comment
                },
                child: Text(
                  'Add Comment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appCore.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: report error
                },
                child: Text(
                  'Report Error',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 600.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 600.ms);
  }
}
