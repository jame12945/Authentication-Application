import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_pallete.dart';
import 'package:test_app/features/auth/presentation/widgets/data_widget.dart';

class DataInputItemWidget extends StatelessWidget {
  const DataInputItemWidget(
      {super.key, required this.text, required this.topic});

  final String text;
  final String topic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            topic,
            style: TextStyle(
              color: AppPallete.focusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          DataItemWidget(
            text: text,
          ),
        ],
      ),
    );
  }
}
