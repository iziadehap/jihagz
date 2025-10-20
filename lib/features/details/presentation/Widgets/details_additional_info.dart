import 'package:flutter/material.dart';
import 'package:jihagz/features/details/data/data_source/details_controller.dart';
import '../../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailsAdditionalInfo extends StatelessWidget {
  final DetailsController controller;
  const DetailsAdditionalInfo({Key? key, required this.controller})
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.price.value.isNotEmpty)
                  Text(
                    'Price: ${controller.price.value}',
                    style: TextStyle(
                      fontSize: 16,
                      color: appCore.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (controller.workingHours.value.isNotEmpty)
                  Text(
                    'Working Hours: ${controller.workingHours.value}',
                    style: TextStyle(fontSize: 16, color: appCore.textColor),
                  ),
                if (controller.facilities.isNotEmpty)
                  Text(
                    'Facilities: ${controller.facilities.join(", ")}',
                    style: TextStyle(fontSize: 16, color: appCore.textColor),
                  ),
                // TODO: Show visitor images if available
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 500.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 500.ms);
  }
}
