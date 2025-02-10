import 'package:flutter/material.dart';
import 'package:chatbot_test/core/theme/color_manager.dart';

class WarningBanner extends StatelessWidget {
  final String title;
  const WarningBanner({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.errorAccent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorManager.errorBorder,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: ColorManager.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: ColorManager.error, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
