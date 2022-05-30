import 'package:flutter/material.dart';
import 'package:per_note/providers/account_provider.dart';
import 'package:per_note/providers/album_provider.dart';
import 'package:per_note/providers/auth_provider.dart';
import 'package:per_note/providers/detail_healthy_index_provider.dart';
import 'package:per_note/providers/healthy_index_provider.dart';
import 'package:per_note/providers/image_provider.dart';
import 'package:per_note/providers/loading_provider.dart';
import 'package:per_note/providers/note_provider.dart';
import 'package:per_note/providers/task_provider.dart';
import 'package:per_note/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'config/app_router.dart';
import 'config/theme.dart';
import 'screens/screens.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
        ChangeNotifierProvider(create: (_) => ImagesProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => HealthyIndexProvider()),
        ChangeNotifierProvider(create: (_) => DetailHealthyIndexProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Notebook',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
