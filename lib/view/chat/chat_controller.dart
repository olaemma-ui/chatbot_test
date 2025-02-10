import 'dart:async';
import 'package:chatbot_test/core/routes/routes.dart';
import 'package:chatbot_test/data/models/chat_model.dart';
import 'package:chatbot_test/data/repository/bots_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  Timer? _timer;
  Timer? _interactionTimer;
  RxBool hasInteracted = false.obs; // Observable variable to track interaction

  bool isLoading = false;
  bool isLoadingLiveAgent = false;

  final messageController = TextEditingController();
  String message = '';

  List<ChatMessage> chats = [];
  int sec = 30;

  @override
  void onInit() {
    super.onInit();
    _startTimeoutTimer();
  }

  /// Starts the main inactivity timer
  void _startTimeoutTimer() {
    _timer?.cancel();
    sec = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!hasInteracted.value) {
        sec--;
        update();
      }
      if (sec <= 0) {
        _handleTimeout();
      }
    });
  }

  /// Handles inactivity timeout
  void _handleTimeout() {
    if (!hasInteracted.value) {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  /// Detects user interaction and resets the timer after 5 seconds
  void userInteractionDetected() {
    hasInteracted.value = true;
    _interactionTimer?.cancel();

    _interactionTimer = Timer(const Duration(seconds: 5), () {
      hasInteracted.value = false;
    });

    sec = 30; // Reset the countdown
    update();
  }

  bool hasUserInteracted() {
    return hasInteracted.value;
  }

  /// Handles sending user messages
  Future<void> sendMessage() async {
    chats.add(
      ChatMessage(
        sender: "user",
        message: messageController.text,
        timestamp: DateTime.now(),
      ),
    );
    message = messageController.text;
    messageController.clear();
    await Future.delayed(const Duration(seconds: 5));
    isLoading = true;
    update();

    userInteractionDetected();
    isLoading = false;
    _botResponse();
  }

  /// Handles bot responses
  Future<void> _botResponse() async {
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
      isLoadingLiveAgent = true;
      update();
      await Future.delayed(const Duration(seconds: 5));

      chats.add(
        ChatMessage(
          sender: "bot",
          message: "Hello, I'm OlaEmma, your live agent support.",
          timestamp: DateTime.now(),
        ),
      );
      isLoadingLiveAgent = false;
    }
    update();

    userInteractionDetected();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _interactionTimer?.cancel();
    super.onClose();
  }
}
