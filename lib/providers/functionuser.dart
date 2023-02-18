import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import '../services/user_service.dart';

import './user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'auth.dart';

class Users extends ChangeNotifier {
  final HttpClient = http.Client();
  bool isLoading = false;
  final _serviceUser = UserService();
  List<Customer> _itemsUser = [];

  List<Customer> get itemsUser {
    return [..._itemsUser];
  }

  Customer findbyId(int id) {
    return _itemsUser.firstWhere(
      (element) => element.id == id,
    );
  }

  Customer findLastbyId(String id) {
    return _itemsUser.lastWhere((element) => element.id == id);
  }

  Customer findbyName(String name) {
    return _itemsUser.firstWhere((element) => element.Name == name);
  }

  Customer findbyEmail(String email) {
    return _itemsUser.firstWhere((element) => element.Email == email);
  }

  String findEmail(String email) {
    var _user = _itemsUser.where((element) => element.Email.contains(email));
    if (_user != null) {
      return email;
    }
    return email;
  }
  // Customer findClubId(int id) {
  //   Customer customer = _itemsUser.firstWhere((e) => e.clubId == id);
  //   _clubs.itemsUser.add(customer);
  //   return customer;
  // }

  Customer? findPersonUsingLoop(String personName) {
    Customer? customer = null;
    print(_itemsUser.length);
    for (var i = 0; i < _itemsUser.length; i++) {
      if (_itemsUser[i].Email == personName) {
        // Found the person, stop the loop
        return _itemsUser[i];
      }
    }
    return customer;
  }

  // Future<User> find(int id) async {
  //   var response = await http.get("${BASE_URL}/findall");
  // }
  Future<List<Customer>?> getDataUser() async {
    var client = http.Client();
    var uri = Uri.parse('https://63e932c3811db3d7eff8ae6a.mockapi.io/users');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
  }

  Future<void> getData() async {
    final response = await _serviceUser.getAll();
    _itemsUser = response;
    notifyListeners();
  }

  Future<void> getAllDataUser() async {
    isLoading = true;
    notifyListeners();

    final response = await _serviceUser.getAll();
    _itemsUser = response;
    isLoading = false;

    notifyListeners();
  }

  Map<String, dynamic>? customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };
  bool loading = false;
  bool isBack = false;
  Future<void> addData(Customer user) async {
    loading = true;
    notifyListeners();
    var client = http.Client();
    var uri = Uri.parse('https://63e932c3811db3d7eff8ae6a.mockapi.io/users');
    var s = user.toJson();
    var studentbody = json.encode(s);

    var response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: studentbody);
    if (response.statusCode == 200) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }

  Future<void> addUser(Customer user) async {
    try {
      final response = await http.post(
        Uri.parse('https://63e932c3811db3d7eff8ae6a.mockapi.io/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'id': user.id,
          'name': user.Name,
          'phone': user.Phone,
          'dateOfBirth': user.DateOfBirth.toString(),
          'email': user.Email,
          'address': user.Address,
          'imagepath': user.imagePath,
          'age': user.Age,
          'gender': user.gender,
          'description': user.Description,
          'rate': user.rate,
          'follow': user.follow,
        }),
      );
      final newUser = Customer(
        Name: user.Name,
        Phone: user.Phone,
        DateOfBirth: user.DateOfBirth,
        Email: user.Email,
        // Target: user.Target,
        Address: user.Address,
        Age: user.Age,
        imagePath: user.imagePath,
        gender: user.gender,
        Description: user.Description,
        follow: user.follow,
        rate: user.rate,
        isFavorite: user.isFavorite,
        id: user.id,
      );
      _itemsUser.add(newUser);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateUser(int id, Customer user) async {
    final prodIndex = _itemsUser.indexWhere((prod) => prod.id == user.id);
    if (prodIndex >= 0) {
      final url = 'https://63e932c3811db3d7eff8ae6a.mockapi.io/users/${id}';
      await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'name': user.Name,
            'phone': user.Phone,
            'dateOfBirth': user.DateOfBirth,
            'email': user.Email,
            'address': user.Address,
            'imagepath': user.imagePath,
            'gender': user.gender,
            'age': user.Age,
            'rate': user.rate,
            'description': user.Description,
            'follow': user.follow,
            'favorite': user.isFavorite,
          }));
      _itemsUser[prodIndex] = user;
      notifyListeners();
    } else {
      print('...');
    }
  }

  bool isFavorite = false;
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(int userid, Customer user) async {
    final prodIndex = _itemsUser.indexWhere((prod) => prod.id == userid);
    if (prodIndex > 0) {
      final oldStatus = isFavorite;
      isFavorite = !isFavorite;
      notifyListeners();
      final url = 'https://63e932c3811db3d7eff8ae6a.mockapi.io/users/${userid}';

      try {
        final response = await http.put(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              'name': user.Name,
              'phone': user.Phone,
              'dateOfBirth': user.DateOfBirth,
              'email': user.Email,
              'address': user.Address,
              'imagepath': user.imagePath,
              'gender': user.gender,
              'age': user.Age,
              'rate': user.rate,
              'description': user.Description,
              'follow': user.follow,
              'favorite': user.isFavorite,
            }));
        _itemsUser[prodIndex] = user;
        notifyListeners();

        if (response.statusCode >= 400) {
          _setFavValue(oldStatus);
        }
      } catch (error) {
        _setFavValue(oldStatus);
      }
    }
  }

  List<Customer> get favoriteItems {
    return _itemsUser.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> updateUserByEmail(String email, Customer user) async {
    final prodIndex = _itemsUser.indexWhere((prod) => prod.Email == email);
    if (prodIndex >= 0) {
      final url =
          'https://63e932c3811db3d7eff8ae6a.mockapi.io/users/${prodIndex}';
      await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'name': user.Name,
            'phone': user.Phone,
            'dateOfBirth': user.DateOfBirth,
            'email': user.Email,
            'address': user.Address,
            'imagepath': user.imagePath,
            'age': user.Age,
            'gender': user.gender,
            'rate': user.rate,
            'follow': user.follow,
            'description': user.Description,
            'favorite': user.isFavorite,
          }));
      _itemsUser[prodIndex] = user;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
