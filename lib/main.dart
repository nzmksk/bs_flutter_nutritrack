import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'cubits/cubits.dart';
import 'firebase_options.dart';
import 'root_page.dart';

Future<void> main() async {
  await dotenv.load();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBarTitleCubit>(
          create: (BuildContext context) => AppBarTitleCubit(),
        ),
        BlocProvider<NavigationCubit>(
          create: (BuildContext context) => NavigationCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'NutriTrack',
        theme: ThemeData(
          snackBarTheme:
              const SnackBarThemeData(backgroundColor: Colors.indigo),
          primarySwatch: Colors.indigo,
        ),
        home: const RootPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
