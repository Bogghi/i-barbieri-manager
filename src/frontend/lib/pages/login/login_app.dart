// main dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// widgets
import 'package:frontend/pages/shared/confirmation_button.dart';
import 'package:frontend/providers/auth_provider.dart';

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
                decoration: InputDecoration(
                  labelText: 'User',
                  error: context.watch<AuthProvider>().usernameError() ? Row(children: [
                    Icon(Icons.error, color: Theme.of(context).colorScheme.error),
                    const SizedBox(width: 2),
                    Text("Username non valido", style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],) : null,
                  errorStyle: TextStyle(color: Theme.of(context).colorScheme.error)
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: !context.watch<AuthProvider>().passwordVisible(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  error: context.watch<AuthProvider>().usernameError() ? Row(children: [
                    Icon(Icons.error, color: Theme.of(context).colorScheme.error),
                    const SizedBox(width: 2),
                    Text("Password non valida", style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],) : null,
                  errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
                  suffix: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTapDown: (tapDownDetails) {
                        context.read<AuthProvider>().setPasswordVisible(true);
                      },
                      onTapUp: (tapDownDetails) {
                        context.read<AuthProvider>().setPasswordVisible(false);
                      },
                      child: context.read<AuthProvider>().passwordVisible() ?
                        const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                )
              ),
              const SizedBox(height: 30,),
              ConfirmationButton(
                label: 'Accedi',
                onPressed: (){
                  bool correctFields = usernameController.text.isEmpty && passwordController.text.isEmpty;
                  context.read<AuthProvider>().setUsernameError(usernameController.text.isEmpty);
                  context.read<AuthProvider>().setPasswordError(passwordController.text.isEmpty);

                  if(!correctFields) {
                    context.read<AuthProvider>().verifyCredentials(usernameController.text, passwordController.text);
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
