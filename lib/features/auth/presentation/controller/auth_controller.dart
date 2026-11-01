import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/login/login_event.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_event.dart';
import 'package:thinksy_ai/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:thinksy_ai/features/auth/presentation/pages/register_page.dart';

class AuthController {
  static void submitForgotPassword(GlobalKey<FormState> formKey, BuildContext context, TextEditingController emailController) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    FocusScope.of(context).unfocus();
    context
        .read<ForgotPasswordBloc>()
        .add(ForgotPasswordSubmitted(emailController.text));
  }
 static void submitLoginPage(GlobalKey<FormState> formKey, BuildContext context, TextEditingController passwordController,TextEditingController emailController
  ) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    FocusScope.of(context).unfocus();
    context.read<LoginBloc>().add(
          LoginSubmitted(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }


 static void openRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const RegisterPage()),
    );
  }

 static void openForgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const ForgotPasswordPage(),
      ),
    );
  }
  
static  String? validateConfirm(String? value, TextEditingController passwordController) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

 static void submitRegister(GlobalKey<FormState> formKey, BuildContext context, TextEditingController passwordController,TextEditingController emailController,TextEditingController nameController) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    FocusScope.of(context).unfocus();
    context.read<RegisterBloc>().add(
          RegisterSubmitted(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }
}