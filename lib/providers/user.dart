import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

List<Customer> postFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));
String userToJson(List<Customer> user) =>
    json.encode(List<dynamic>.from(user.map((e) => e.toJson())));

class Customer with ChangeNotifier {
  final int id;
  final String Name;
  final String Phone;
  String Email;
  final String Age;
  String? gender;
  int? rate;
  String imagePath;
  String Address;
  final String DateOfBirth;
  final String Description;
  int follow = 0;
  bool isFavorite;

  Customer({
    required this.id,
    required this.Name,
    required this.Phone,
    required this.Email,
    required this.Address,
    required this.DateOfBirth,
    required this.Age,
    required this.imagePath,
    required this.gender,
    required this.Description,
    required this.follow,
    required this.rate,
    this.isFavorite = false,
  });
  // int get _age => Age!;
  // set _age(int value) {
  //   Age = value;
  // }

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: int.parse(json["id"]),
        Name: json["name"],
        DateOfBirth: json["dateOfBirth"].toString(),
        Phone: json["phone"],
        Email: json["email"],
        Address: json["address"],
        Age: json["age"],
        gender: json["gender"],
        imagePath: json["imagepath"],
        Description: json["description"],
        follow: json["follow"],
        rate: json["rate"],
        isFavorite: json["favorite"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": Name,
        "phone": Phone,
        "dateOfBirth": DateOfBirth,
        "email": Email,
        "address": Address,
        "age": Age,
        "imagepath": imagePath,
        "gender": gender,
        "description": Description,
        "follow": follow,
        "rate": rate,
        "favorite": isFavorite,
      };
}
