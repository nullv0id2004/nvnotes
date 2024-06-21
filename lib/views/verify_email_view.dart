import 'package:flutter/material.dart';
import 'package:nvnotes/constants/routes.dart';
import 'package:nvnotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
      ),
      body: Column(
        children: [
          const Text(
              'We have sent you a email verification. Please open it to verify your email'),
          const Text(
              'if you have\'nt recieved the verification then press button'),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerificaiton();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();

                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text("sign out"))
        ],
      ),
    );
  }
}
