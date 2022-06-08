// ----- STRINGS ------

import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';

//http://127.0.0.1:8000
//http://192.168.201.13:8000
const baseURL = 'http://192.168.201.13:8000/api';
const loginagenceURL = baseURL + '/login';
const registeragenceURL = baseURL + '/register';
//___________________
const login_clientURL = baseURL + '/login_client';
const register_clientURL = baseURL + '/register_client';
const logoutURL = baseURL + '/logout';
const myoffersURL = baseURL + '/myoffer';
const agenceURL = baseURL + '/agence';
const offersURL = baseURL + '/offer';
const userURL = baseURL + '/user';
const postsURL = baseURL + '/posts';
const commentsURL = baseURL + '/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

// --- input decoration
InputDecoration kInputDecoration(String label, IconData icon) {
  return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
          child: Text(label, style: TextStyle(color: COLOR_1)),
          onTap: () => onTap())
    ],
  );
}

// likes and comment btn

Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: 4),
              Text('$value')
            ],
          ),
        ),
      ),
    ),
  );
}
