import 'dart:convert';
import 'package:email_temporario/app/data/api/data_email.dart';
import 'package:email_temporario/app/data/models/account_base.dart';
import 'package:email_temporario/app/data/models/token_model.dart';
import 'package:get/get.dart';

import '../../../global/models/account.dart';

class HomeRepository {
  final _dataEmail = DataEmail();
  AccountData account = Get.find();
  // final token =
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2NzEzNjY3MTAsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6Im1hcmN1c0BuaWdodG9yYi5jb20iLCJpZCI6IjYzOWYwNzkyMWU3MzE5MTBhZDEzZGQyNCIsIm1lcmN1cmUiOnsic3Vic2NyaWJlIjpbIi9hY2NvdW50cy82MzlmMDc5MjFlNzMxOTEwYWQxM2RkMjQiXX19.wESMqKK6g745RuDXbcMqY_ihOmAuPyyVmEwSfeLnSWosWvFOIaEP9owynRykaxs_kf77GmddBq4YoIdkBFylZA';

  Future<Map<String, dynamic>> getDomains() async {
    final response = await _dataEmail.getDomains();

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> createAccount({
    required String address,
    required String pass,
    required String domain,
  }) async {
    final response = await _dataEmail.createAccount(
      account: AccountBase(
        address: '$address$domain',
        password: pass,
      ),
    );

    if (response.statusCode == 201) {
      await account.setData(key: "address", value: address);
      await account.setData(key: "pass", value: pass);
      await account.setData(key: "domain", value: domain);

      return json.decode(response.body);
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> createToken() async {
    await account.loadData();

    if (account.address.isNotEmpty && account.pass.isNotEmpty) {
      final response = await _dataEmail.createToken(
        account: AccountBase(
          address: '${account.address}${account.domain}',
          password: account.pass,
        ),
      );

      if (response.statusCode == 200) {
        final j = json.decode(response.body);
        final tokenModel = TokenModel.fromJson(j);

        await account.setData(key: "token", value: tokenModel.token);
        await account.setData(key: "id", value: tokenModel.id);

        return j;
      } else {
        return {};
      }
    } else {
      return {};
    }
  }

  Future<int> deleteAccount() async {
    final response = await _dataEmail.deleteAccount(
      idAccount: account.id,
      token: account.token,
    );

    return response.statusCode;
  }

  Future<int> deleteMessage({required String idMessage}) async {
    final response = await _dataEmail.deleteMessage(
      idMessage: idMessage,
      token: account.token,
    );

    return response.statusCode;
  }

  Future<Map<String, dynamic>> getAllMessages() async {
    final response = await _dataEmail.getAllMessages(token: account.token);

    return response.statusCode == 200 ? json.decode(response.body) : {};
  }

  Future<Map<String, dynamic>> getMessage({required String idMessage}) async {
    final response = await _dataEmail.getMessage(
      idMessage: idMessage,
      token: account.token,
    );

    return response.statusCode == 200 ? json.decode(response.body) : {};
  }
}
