import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paypie/features/auth/provider/auth_provider.dart';
import 'package:paypie/features/auth/view/login_email_pass.dart';
import 'package:paypie/features/auth/view/auth_phone_otp.dart';
import 'package:paypie/utils/screen_config.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PayPie',
        theme: ThemeData(
          fontFamily: "Raleway",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PhoneLogin(),
      ),
    );
  }
}
