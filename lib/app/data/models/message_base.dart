import 'dart:convert';

import 'package:email_temporario/app/data/models/message_details.dart';

MessageBase messagesModelFromJson(String str) =>
    MessageBase.fromJson(json.decode(str));

String messageBaseToJson(MessageBase data) => json.encode(data.toJson());

class MessageBase {
  MessageBase({
    required this.colorAvatar,
    required this.nameAvatar,
    required this.message,
  });

  final int colorAvatar;
  final String nameAvatar;
  final MessageDetails message;

  factory MessageBase.fromJson(Map<String, dynamic> json) => MessageBase(
        colorAvatar: json["colorAvatar"],
        nameAvatar: json["nameAvatar"],
        message: messageDetailsFromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "colorAvatar": colorAvatar,
        "nameAvatar": nameAvatar,
        "message": messageDetailsToJson(message),
      };
}
