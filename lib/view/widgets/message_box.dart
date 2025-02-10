import 'package:chatbot_test/core/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final String sender;
  const MessageBox({
    super.key,
    required this.message,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // margin: EdgeInsets.only(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: sender == "bot"
            ? const Color.fromARGB(29, 64, 64, 64)
            : const Color.fromARGB(167, 245, 245, 245),
      ),
      constraints: BoxConstraints(
        maxWidth: context.screenWidth / 1.4,
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        overflow: TextOverflow.clip,
      ),
    );
  }
}
