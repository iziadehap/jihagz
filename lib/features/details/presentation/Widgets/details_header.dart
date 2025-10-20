import 'package:flutter/material.dart';
import 'package:jihagz/features/details/data/data_source/details_controller.dart';
import '../../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailsHeader extends StatelessWidget {
  final DetailsController controller;
  const DetailsHeader({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCore = AppCore();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: isDark ? 0 : 3,
          color: isDark ? appCore.surfaceColor : Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.sports_soccer,
              size: 40,
              color: appCore.primaryColor,
            ),
            title: Text(
              controller.name.value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: appCore.textColor,
              ),
            ),
            subtitle: Text(
              controller.type.value,
              style: TextStyle(
                fontSize: 16,
                color: appCore.textColor.withOpacity(0.7),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms);
  }
}
