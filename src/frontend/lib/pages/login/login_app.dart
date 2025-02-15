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
                decoration: const InputDecoration(labelText: 'User'),
              ),
              TextField(
                controller: passwordController,
                obscureText: !context.watch<AuthProvider>().passwordVisible(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffix: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTapDown: (tapDownDetails) {
                        context.read<AuthProvider>().togglePasswordVisibility();
                      },
                      child: context.read<AuthProvider>().passwordVisible() ?
                        const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                )
              ),
              const SizedBox(height: 30,),
              Visibility(
                visible: context.watch<AuthProvider>().credentialError(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.error),
                      context.watch<AuthProvider>().errorMsg() ?? ''
                    ),
                  ),
                )
              ),
              const Visibility(child: SizedBox(height: 30,)),
              ConfirmationButton(
                label: 'Accedi',
                onPressed: () async {
                  await context
                      .read<AuthProvider>()
                      .verifyCredentials(usernameController.text, passwordController.text, context);
                }
              ),
              const SizedBox(height: 30,),
              ConfirmationButton(
                label: 'Registrati',
                onPressed: (){
                  context
                      .read<AuthProvider>()
                      .signup(usernameController.text, passwordController.text, context);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
