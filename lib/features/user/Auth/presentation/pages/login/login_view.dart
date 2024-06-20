import 'package:firebase_auth_platform_interface/src/providers/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/login_view_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required List<EmailAuthProvider> providers});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginViewBody(),
    );
  }
}