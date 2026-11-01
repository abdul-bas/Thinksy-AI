import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';
import 'package:thinksy_ai/core/utils/validators/validators.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/login/login_event.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/login/login_state.dart';
import 'package:thinksy_ai/features/auth/presentation/controller/auth_controller.dart';
import 'package:thinksy_ai/core/widgets/auth_gate.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_header.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_text_field.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == FormStatus.failure,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Sign in failed.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
      },
      child: AuthGate(
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const AuthHeader(
                          icon: Icons.auto_awesome,
                          title: 'Welcome back',
                          subtitle: 'Sign in to continue with Thinksy AI',
                        ),
                        AuthTextField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.isPasswordVisible !=
                              current.isPasswordVisible,
                          builder: (context, state) {
                            return AuthTextField(
                              controller: passwordController,
                              label: 'Password',
                              icon: Icons.lock_outline_rounded,
                              obscureText: !state.isPasswordVisible,
                              textInputAction: TextInputAction.done,
                              autofillHints: const [AutofillHints.password],
                              validator: Validators.password,
                              onFieldSubmitted: (value) => AuthController.submitLoginPage(formKey, context, passwordController, emailController),
                              suffix: IconButton(
                                icon: Icon(
                                  state.isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                                onPressed: () => context.read<LoginBloc>().add(
                                      const LoginPasswordVisibilityToggled(),
                                    ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed:() =>  AuthController.openForgotPassword,
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return AuthSubmitButton(
                              label: 'Sign in',
                              isLoading: state.status == FormStatus.loading,
                              onPressed:() => AuthController.submitLoginPage(formKey, context, passwordController, emailController),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed:() => AuthController. openRegister(context),
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                     ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}