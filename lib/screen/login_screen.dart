import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showLoginError() {
    final snackbar = SnackBar(
      content: Text(
        'Invalid Login',
        style: TextStyle(color: Colors.pinkAccent, fontSize: 20.0),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void showNetworkError() {
    final snackbar = SnackBar(
      content: Text(
        'Network Error',
        style: TextStyle(color: Colors.pinkAccent, fontSize: 20.0),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void onLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;
    print('username: $username, password: $password');

    try {
      QuerySnapshot snapshot = await users
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();
      var docs = snapshot.docs;
      if (docs.length > 0) {
        print('user is present');
        print(docs[0].get("username"));
        print(docs[0].get("password"));
        usernameController.text = '';
        passwordController.text = '';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }),
        );
      } else {
        print('user is not presentd');
        showLoginError();
      }
    } catch (error) {
      showNetworkError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: SvgPicture.asset('images/cost.svg'),
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.only(bottom: 20.0),
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20),
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
      ),
    );
  }
}
