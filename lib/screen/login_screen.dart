import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onLogin(){
    final username = usernameController.text;
    final password = passwordController.text;
    print('username: $username, password: $password');
    usernameController.text = '';
    passwordController.text = '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(fontSize: 20),
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 20),
                ),
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                color: Colors.blue,
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: RaisedButton(
                  onPressed: onLogin,
                  color: Colors.blue,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
