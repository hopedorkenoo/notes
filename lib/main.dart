import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:notez/constants/firebase_messaging_handler.dart';
import 'package:notez/locater.dart';
import 'package:notez/pages/pages.dart';
import 'package:notez/providers/LabelsProvider.dart';
import 'package:notez/providers/notesProvider.dart';
import 'package:notez/providers/authenticationProvider.dart';
import 'package:notez/widgets/bottom_navigator.dart';
import 'package:provider/provider.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PushNotificationService _pushNotificationService =
      sl.get<PushNotificationService>();
  @override
  void initState() {
    super.initState();
    // _pushNotificationService.initialize(
    //     context, authProvider.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotesProvider>(
          create: (_) => NotesProvider(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<LabelsProvider>(
          create: (_) => LabelsProvider(),
        ),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          _pushNotificationService.initialize(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: authProvider.currentUsercheck() ? BaseScreen() : SignUp(),
          );
        },
      ),
    );
  }
}
