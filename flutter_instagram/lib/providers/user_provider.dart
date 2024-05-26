import 'package:flutter/widgets.dart';
import 'package:flutter_instagram/models/user.dart';
import 'package:flutter_instagram/firebase/authentication.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Authentication _authMethods = Authentication();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}