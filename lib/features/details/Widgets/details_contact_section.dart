import 'package:flutter/material.dart';
import '../controllers/details_controller.dart';
import '../../../core/appCore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailsContactSection extends StatelessWidget {
  final DetailsController controller;
  const DetailsContactSection({Key? key, required this.controller})
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
            leading: Icon(Icons.phone, color: appCore.primaryColor),
            title: Text(
              'Phone: ${controller.phone.value}',
              style: TextStyle(
                color: appCore.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.call, color: appCore.successColor),
                  onPressed: () {
                    // TODO: call now
                  },
                ),
                if (controller.whatsapp.value.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.message, color: appCore.secondaryColor),
                    onPressed: () {
                      // TODO: open WhatsApp
                    },
                  ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 400.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 400.ms);
  }
}
