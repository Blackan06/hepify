import 'dart:convert';
import 'dart:io';

import '../providers/user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // import at the top of the page.

class UserService {
  Future<List<Customer>> getAll() async {
    const url = 'https://63d92f7fbaa0f79e09b6d815.mockapi.io/users';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final users =
          (json["results"] as List).map((e) => Customer.fromJson(e)).toList();

      return users;
    }
    throw 'error';
  }
}

Future<Customer> fetchAlbum(int id) async {
  final response = await http
      .get(Uri.parse('https://63d92f7fbaa0f79e09b6d815.mockapi.io/users/$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Customer.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
