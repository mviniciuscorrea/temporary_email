import 'package:email_temporario/app/data/models/account_base.dart';
import 'package:http/http.dart' as http;
import '../const_api.dart';

class DataEmail {
  final _api = ConstAPI();

  Future<http.Response> getDomains() async {
    final response = await http.get(
      Uri.parse('${_api.urlApiEmailBase}/domains'),
    );

    return response;
  }

  Future<http.Response> createAccount({
    required AccountBase account,
  }) async {
    final response = await http.post(
      Uri.parse('${_api.urlApiEmailBase}/accounts'),
      headers: _api.headers,
      body: createAccountModelToJson(account),
    );

    return response;
  }

  Future<http.Response> createToken({
    required AccountBase account,
  }) async {
    final response = await http.post(
      Uri.parse('${_api.urlApiEmailBase}/token'),
      headers: _api.headers,
      body: createAccountModelToJson(account),
    );

    return response;
  }

  Future<http.Response> deleteAccount({
    required String idAccount,
    required String token,
  }) async {
    final response = await http.delete(
      Uri.parse('${_api.urlApiEmailBase}/accounts/$idAccount'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response;
  }

  Future<http.Response> deleteMessage({
    required String idMessage,
    required String token,
  }) async {
    final response = await http.delete(
      Uri.parse('${_api.urlApiEmailBase}/messages/$idMessage'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response;
  }

  Future<http.Response> getAllMessages({required String token}) async {
    final response = await http.get(
      Uri.parse('${_api.urlApiEmailBase}/messages'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response;
  }

  Future<http.Response> getMessage({
    required String idMessage,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('${_api.urlApiEmailBase}/messages/$idMessage'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response;
  }
}
