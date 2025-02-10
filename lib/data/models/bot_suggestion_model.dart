// ignore: file_names
class BotSuggestionModel {
  final String title;
  final String body;
  final String response;

  BotSuggestionModel({
    required this.title,
    required this.body,
    required this.response,
  });

  factory BotSuggestionModel.fromJson(Map<String, dynamic> json) {
    return BotSuggestionModel(
      title: json['title'],
      body: json['body'],
      response: json['response'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'response': response,
    };
  }
}
