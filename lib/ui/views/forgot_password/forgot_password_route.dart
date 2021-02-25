import 'package:flutter/material.dart';

class ForgotPasswordRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Forgot Your Password'),
              Text('Instructions for forgotten password'),
              RaisedButton(
                onPressed: () async {
                  //@TODO Send a password generation link
                  Navigator.pop(context);
                },
                child: Text('SEND'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
