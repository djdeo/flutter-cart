import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../screens/cart_screen.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'identifier': '',
    'password': '',
  };

  final _passwordController = TextEditingController();
  String baseUrl = 'http://192.168.0.70:1337/auth/local';

  void _switchAuthMode() {
    _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    setState(() {});
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {Navigator.of(ctx).pop();},
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    print(_authData);

    try {
      if(_authMode == AuthMode.Login) {
        var res = await Dio().post(baseUrl, data: {
          'identifier': _authData['email'],
          'password': _authData['password'],
        });
        print(res);
        // strapi api data related
        Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
      }
    } catch(error) {
      print(error);
      _showErrorMessage(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
          height: _authMode == AuthMode.Signup ? 320 : 260,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.Signup ? 320 : 260),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return (value.isEmpty || !value.contains('@'))
                            ? 'Please use valid email!'
                            : null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        return (value.isEmpty || value.length < 5)
                            ? 'Password is too short!'
                            : null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (_authMode == AuthMode.Signup)
                            ? (value) {
                                return value != _passwordController.text
                                    ? 'Passwords do not match!'
                                    : null;
                              }
                            : null,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                      onPressed: _submit,
                    ),
                    FlatButton(
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} Instead'),
                      onPressed: _switchAuthMode,
                    )
                  ],
                ),
              ))),
    );
  }
}
