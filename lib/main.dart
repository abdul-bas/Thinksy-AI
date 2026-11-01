import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thinksy_ai/firebase_options.dart';
import 'package:thinksy_ai/thinksy_ai_app.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ThinksyApp());
}

