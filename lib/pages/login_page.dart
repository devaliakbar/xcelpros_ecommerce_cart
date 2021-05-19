import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/pages/feed_page.dart';
import 'package:ecommerce/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoginButtonLoading = false;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkAlredyLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Graphql Mutation"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 22),
                    ),
                    TextField(
                      key: Key("emailKey"),
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    TextField(
                      key: Key("passwordKey"),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      key: Key("loginBtnKey"),
                      onPressed: login,
                      child: _isLoginButtonLoading
                          ? CircularProgressIndicator()
                          : Text("Login"),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> checkAlredyLogin() async {
    // if (await GraphQLConfig().isUserLogedIn()) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       FeedPage.routeName, (Route<dynamic> route) => false);
    // } else {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
    //FOR TESTING PURPOSE

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email == "") {
      showInSnackBar("Please enter email");
      return;
    }

    if (password == "") {
      showInSnackBar("Please enter password");
      return;
    }
    return;
    setState(() {
      _isLoginButtonLoading = true;
    });

    Provider.of<LoginProvider>(context, listen: false)
        .login(email: email, password: password)
        .then((value) {
      if (value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            FeedPage.routeName, (Route<dynamic> route) => false);
      } else {
        setState(() {
          _isLoginButtonLoading = false;
        });
        showInSnackBar("Failed to login");
      }
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(seconds: 2),
    ));
  }
}
