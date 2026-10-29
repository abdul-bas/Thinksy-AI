import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/core/network/dio_client.dart';
import 'package:thinksy_ai/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:thinksy_ai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:thinksy_ai/features/chat/domain/usecases/send_message.dart';
import 'package:thinksy_ai/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:thinksy_ai/features/chat/presentation/pages/chat_page.dart';
class ThinksyApp extends StatelessWidget {
  const ThinksyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = const DioClient().create();
    final dataSource = ChatRemoteDataSourceImpl(dio);
    final repository = ChatRepositoryImpl(dataSource);
    final sendMessage = SendMessage(repository);

    const seed = Color(0xFF6C5CE7);

    return BlocProvider(
      create: (context) => ChatBloc(sendMessage: sendMessage),
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
        home: const ChatPage(),
      ),
    );
  }
}