import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    required this.context,
    required this.id,
    required this.type,
    required this.accountModelId,
    required this.address,
    required this.quota,
    required this.used,
    required this.isDisabled,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String context;
  final String id;
  final String type;
  final String accountModelId;
  final String address;
  final int quota;
  final int used;
  final bool isDisabled;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        accountModelId: json["id"],
        address: json["address"],
        quota: json["quota"],
        used: json["used"],
        isDisabled: json["isDisabled"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "id": accountModelId,
        "address": address,
        "quota": quota,
        "used": used,
        "isDisabled": isDisabled,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
