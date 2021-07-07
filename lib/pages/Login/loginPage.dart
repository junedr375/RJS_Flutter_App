import 'package:artapp/main.dart';
import 'package:artapp/widgets/AppComponents.dart';
import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeDataOfContext(context);
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: mainAxisHeight,
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In',
                  style: theme.textTheme.headline3,
                ),
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: theme.highlightColor,
                      fontSize: theme.textTheme.headline2?.fontSize,
                      fontWeight: theme.textTheme.headline2?.fontWeight),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please sign in to continue',
                  style: theme.textTheme.headline5,
                ),
              ),
              SizedBox(height: 50),
              appTextFormField(
                  controller: _usernameController, name: 'Username')
            ],
          ),
        ),
      ),
    ));
  }
}
