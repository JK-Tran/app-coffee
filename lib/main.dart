import 'package:app_shopping/providers/auth_provider.dart';
import 'package:app_shopping/providers/register_provider.dart';
import 'package:app_shopping/screen/register_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  //   appleProvider: AppleProvider.deviceCheck,
  // );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug, // Chế độ debug cho Android
    appleProvider: AppleProvider.debug,    // Chế độ debug cho iOS
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return  GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(    
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            textTheme: GoogleFonts.robotoTextTheme(),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: RegisterScreen(),
        );
      },
    );
  }
}

