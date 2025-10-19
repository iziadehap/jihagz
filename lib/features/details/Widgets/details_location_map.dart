import 'package:flutter/material.dart';
import '../controllers/details_controller.dart';
import '../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailsLocationMap extends StatelessWidget {
  final DetailsController controller;
  const DetailsLocationMap({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: isDark ? appCore.surfaceColor : Colors.white,
          elevation: isDark ? 0 : 2,
          child: ListTile(
            leading: Icon(Icons.map, color: appCore.primaryColor),
            title: Text(
              'Location',
              style: TextStyle(
                color: appCore.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: controller.location.value == null
                ? Text(
                    'No location available',
                    style: TextStyle(color: appCore.textColor.withOpacity(0.7)),
                  )
                : Text(
                    'Tap to open in Google Maps',
                    style: TextStyle(color: appCore.textColor.withOpacity(0.7)),
                  ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appCore.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: open in Google Maps
              },
              child: Text('Open in Maps'),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 200.ms);
  }
}
