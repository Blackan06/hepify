import 'dart:convert';

import 'package:flutter/material.dart';

List<Image> postFromJson(String str) =>
    List<Image>.from(json.decode(str).map((x) => Image.fromJson(x)));
String userToJson(List<Image> user) =>
    json.encode(List<dynamic>.from(user.map((e) => e.toJson())));

class Image with ChangeNotifier {
  final int id;
  final String imagePath;

  Image({
    required this.id,
    required this.imagePath,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: int.parse(json["id"]),
        imagePath: json["imagepath"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "imagepath": imagePath,
      };
}
