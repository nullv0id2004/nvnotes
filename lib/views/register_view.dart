import 'package:flutter/material.dart';
import 'package:nvnotes/constants/routes.dart';
import 'package:nvnotes/services/auth/auth_exceptions.dart';
import 'package:nvnotes/services/auth/auth_service.dart';
import 'package:nvnotes/utility/show_error_dialogue.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await AuthService.firebase().createUser(
                          email: email,
                          password: password,
                        );
                        await AuthService.firebase().sendEmailVerificaiton();
                        Navigator.of(context).pushNamed(verifyemailRoute);
                      } on WeakPasswordAuthExcepiton {
                        await ShowErrorDialogue(
                          context,
                          'Weak Password',
                        );
                      } on EmailAlreadyInUseAuthExcepiton {
                        await ShowErrorDialogue(
                          context,
                          'Email already Registered',
                        );
                      } on InvalidEmailAuthExcepiton {
                        await ShowErrorDialogue(
                          context,
                          'Invalid Email',
                        );
                      } on GenericAuthException {
                        await ShowErrorDialogue(
                          context,
                          'Something wrong happened',
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    },
                    child: const Text('Already Registered?, Login'),
                  )
                ],
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
