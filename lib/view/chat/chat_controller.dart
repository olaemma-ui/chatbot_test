import 'dart:async';
import 'package:chatbot_test/core/routes/routes.dart';
import 'package:chatbot_test/data/models/chat_model.dart';
import 'package:chatbot_test/data/repository/bots_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  Timer? _timer;
  RxBool hasInteracted = false.obs; // Observable variable to track interaction

  bool isLoading = false;

  final messageController = TextEditingController();
  String message = '';

  List<ChatMessage> chats = [];
  int sec = 30;

  @override
  void onInit() {
    super.onInit();
    _resetTimer();
  }

  void _resetTimer() {
    _timer?.cancel(); // Cancel any existing timer
    // _timer = Timer(const Duration(seconds: 30), _handleTimeout);
    sec = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      sec--;
      update();
      if (sec == 0) {
        _handleTimeout();
        return;
      }
    });
  }

  void _handleTimeout() {
    if (!hasInteracted.value) {
      // Perform auto-logout or any other action
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void userInteractionDetected() async {
    hasInteracted.value = true; // Mark as interacted
    await Future.delayed(const Duration(seconds: 5));
    hasInteracted.value = false;
    _resetTimer(); // Reset timer on interaction
  }

  bool hasUserInteracted() {
    return hasInteracted.value; // Return interaction status
  }

  sendMessage() async {
    chats.add(
      ChatMessage(
        sender: "user",
        message: messageController.text,
        timestamp: DateTime.now(),
      ),
    );
    message = messageController.text;
    messageController.clear();
    isLoading = true;
    update();
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    _botResponse();
  }

  _botResponse() {
    final response =
        data.where((suggestion) => suggestion['body'] == message).firstOrNull;

    if (response != null) {
      chats.add(
        ChatMessage(
          sender: "bot",
          message: response['response'],
          timestamp: DateTime.now(),
        ),
      );
    } else {
      chats.add(
        ChatMessage(
          sender: "user",
          message: "Rediirecting to a live agent, please wait....",
          timestamp: DateTime.now(),
        ),
      );
    }
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
