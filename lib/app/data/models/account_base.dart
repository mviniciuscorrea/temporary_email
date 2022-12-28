import 'dart:convert';

AccountBase createAccountModelFromJson(String str) =>
    AccountBase.fromJson(json.decode(str));

String createAccountModelToJson(AccountBase data) => json.encode(data.toJson());

class AccountBase {
  AccountBase({
    required this.address,
    required this.password,
  });

  final String address;
  final String password;

  factory AccountBase.fromJson(Map<String, dynamic> json) => AccountBase(
        address: json["address"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "password": password,
      };
}
