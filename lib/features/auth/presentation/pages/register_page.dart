import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';
import 'package:thinksy_ai/core/utils/validators/validators.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_event.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_state.dart';
import 'package:thinksy_ai/features/auth/presentation/controller/auth_controller.dart';
import 'package:thinksy_ai/core/widgets/auth_gate.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_header.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Registration failed.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: AuthGate(
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const AuthHeader(
                          icon: Icons.person_add_alt_1_rounded,
                          title: 'Create account',
                          subtitle: 'Join Thinksy AI and start asking questions',
                        ),
                        AuthTextField(
                          controller: nameController,
                          label: 'Full name',
                          icon: Icons.person_outline_rounded,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.name],
                          validator: Validators.name,
                        ),
                        const SizedBox(height: 16),
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
                        BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) =>
                              previous.isPasswordVisible !=
                              current.isPasswordVisible,
                          builder: (context, state) {
                            return Column(
                              children: [
                                AuthTextField(
                                  controller: passwordController,
                                  label: 'Password',
                                  icon: Icons.lock_outline_rounded,
                                  obscureText: !state.isPasswordVisible,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: Validators.password,
                                  suffix: IconButton(
                                    icon: Icon(
                                      state.isPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                    onPressed: () =>
                                        context.read<RegisterBloc>().add(
                                          const RegisterPasswordVisibilityToggled(),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AuthTextField(
                                  controller: confirmController,
                                  label: 'Confirm password',
                                  icon: Icons.lock_outline_rounded,
                                  obscureText: !state.isPasswordVisible,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) =>
                                      AuthController.validateConfirm(
                                        value,
                                        passwordController,
                                      ),
                                  onFieldSubmitted: (value) =>
                                      AuthController.submitRegister(
                                        formKey,
                                        context,
                                        passwordController,
                                        emailController,
                                        nameController,
                                      ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return AuthSubmitButton(
                              label: 'Create account',
                              isLoading: state.status == FormStatus.loading,
                              onPressed: () => AuthController.submitRegister(
                                formKey,
                                context,
                                passwordController,
                                emailController,
                                nameController,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Sign in'),
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
