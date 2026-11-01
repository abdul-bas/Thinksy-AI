import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/network/dio_client.dart';
import 'package:thinksy_ai/features/auth/data/datasources/auth_remote_data_source_iml.dart';
import 'package:thinksy_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thinksy_ai/features/auth/domain/repositories/auth_repository.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/register.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/send_password_reset.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/sign_in.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/sign_out.dart';
import 'package:thinksy_ai/features/auth/domain/usecases/watch_auth_state.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:thinksy_ai/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:thinksy_ai/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:thinksy_ai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:thinksy_ai/features/chat/domain/repositories/chat_repository.dart';
import 'package:thinksy_ai/features/chat/domain/usecases/send_message.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_bloc.dart';

import 'package:thinksy_ai/features/splash/presentation/pages/splash_page.dart';

class ThinksyApp extends StatelessWidget {
  const ThinksyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = const DioClient().create();

    final authDataSource = AuthRemoteDataSourceImpl(FirebaseAuth.instance);
    final chatDataSource = ChatRemoteDataSourceImpl(dio);

    final authRepository = AuthRepositoryImpl(authDataSource);
    final chatRepository = ChatRepositoryImpl(chatDataSource);

    final signIn = SignIn(authRepository);
    final register = Register(authRepository);
    final sendPasswordReset = SendPasswordReset(authRepository);
    final watchAuthState = WatchAuthState(authRepository);
    final signOut = SignOut(authRepository);
    final sendMessage = SendMessage(chatRepository);

    const seed = Color(0xFF6C5CE7);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<ChatRepository>.value(value: chatRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc(signIn: signIn)),
          BlocProvider(create: (context) => RegisterBloc(register: register)),
          BlocProvider(
            create: (context) =>
                ForgotPasswordBloc(sendPasswordReset: sendPasswordReset),
          ),

          BlocProvider(
            create: (context) =>
                AuthBloc(watchAuthState: watchAuthState, signOut: signOut)
                  ..add(const AuthStarted()),
          ),
          BlocProvider(create: (context) => ChatBloc(sendMessage: sendMessage)),
        ],
        child: MaterialApp(
          title: 'Thinksy AI',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: seed),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seed,
              brightness: Brightness.dark,
            ),
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
