import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double currentValue;
  final double goalValue;
  final Color foregroundColor;
  final Color backgroundColor;
  final String label;

  const ProgressIndicatorWidget(this.currentValue, this.goalValue,
      this.foregroundColor, this.backgroundColor, this.label,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double progress = currentValue / goalValue;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          LinearProgressIndicator(
            value: (progress > 1) ? 1 : progress,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            minHeight: 10,
          ),
          Text('$label $currentValue/$goalValue'),
        ],
      ),
    );
  }
}
