import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/utils/enum/form_status.dart';
import 'package:thinksy_ai/core/utils/validators/validators.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:thinksy_ai/features/auth/presentation/controller/auth_controller.dart';
import 'package:thinksy_ai/core/widgets/auth_gate.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_header.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:thinksy_ai/features/auth/presentation/widgets/auth_text_field.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        if (state.status == FormStatus.success) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Reset link sent. Check your inbox (and spam folder).',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          Navigator.of(context).pop();
        } else if (state.status == FormStatus.failure) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Could not send email.'),
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
                          icon: Icons.lock_reset_rounded,
                          title: 'Forgot password?',
                          subtitle:
                              'Enter your email and we will send you a link to reset your password.',
                        ),
                        AuthTextField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.email],
                          validator: Validators.email,
                          onFieldSubmitted: (value) => AuthController.submitForgotPassword(formKey,context,emailController),
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return AuthSubmitButton(
                              label: 'Send reset link',
                              isLoading: state.status == FormStatus.loading,
                              onPressed:()=> AuthController.submitForgotPassword(formKey,context,emailController),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Back to sign in'),
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