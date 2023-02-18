import 'dart:convert';
import 'dart:io';

import '../providers/user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // import at the top of the page.

class UserService {
  Future<List<Customer>> getAll() async {
    const url = 'https://63e932c3811db3d7eff8ae6a.mockapi.io/users';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      // final users =
      //     (json[0]["users"]).map((e) => Customer.fromJson(e)).toList();
      List<Customer> customers =
          json.map((dynamic e) => Customer.fromJson(e)).toList();
      return customers;
    }
    throw 'error';
  }
}

Future<Customer> fetchAlbum(int id) async {
  final response = await http
      .get(Uri.parse('https://63e932c3811db3d7eff8ae6a.mockapi.io/users/$id'));

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
