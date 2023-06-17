import 'package:coachingapp/providers/firebase_helper.dart';
import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/utils/strings.dart';
import 'package:coachingapp/views/auth/login.dart';
import 'package:coachingapp/views/coach_home.dart';
import 'package:coachingapp/views/client_home.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import 'firebase_options.dart';
import 'models/user.dart';

var uuid = const Uuid();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final providerContainer = ProviderContainer();
  String? finalKey;
  @override
  void initState() {
    super.initState();
    getValidationKey();
    print(finalKey);
  }

  Future getValidationKey() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedKey = sharedPreferences.getString('key');
    setState(() {
      finalKey = obtainedKey;
    });
  }

  UserModel? userModel;
  Future<UserModel> getUserData() async {
    UserModel user = await FirebaseHelper.getUserModelById(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userModel = user;
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      // ignore: non_constant_identifier_names
      builder: (context, Orientation, DeviceType) {
        return ProviderScope(
          parent: providerContainer,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    if (finalKey == 'client') {
                      return const ClientHome(
                      );
                    } else if (finalKey == 'coach') {
                      return const CoachHome();
                      // ignore: unnecessary_null_comparison
                    } else if (finalKey == null) {
                      return const WelcomeScreen();
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.hasError}'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors().primaryColor,
                    ),
                  );
                }
                return const WelcomeScreen();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    providerContainer.dispose(); // Dispose the container when the app is closed
    super.dispose();
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/img.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: screenHeight * 0.8,
          ),
          // Container with content
          Container(
            // padding: EdgeInsets.all(16.0),
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(70))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Welcome',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: AppColors().primaryColor),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.15),
                          child: Text(
                            Strings().welcome,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        LargeButton(
                          name: 'Continue To Login',
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
