// main dependencies
import 'package:flutter/material.dart';
// widgets
import 'package:frontend/pages/shared/confirmation_button.dart';

class LoginApp extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Login", style: TextStyle(fontSize: 25)),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'User'
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password'
                ),
              ),
              const SizedBox(height: 30,),
              ConfirmationButton(
                label: 'Accedi',
                onPressed: (){}
              ),
            ],
          ),
        ),
      ),
    );
  }
}
