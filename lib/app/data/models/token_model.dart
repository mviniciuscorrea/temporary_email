import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  TokenModel({
    required this.token,
    required this.id,
  });

  final String token;
  final String id;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: json["token"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
      };
}
