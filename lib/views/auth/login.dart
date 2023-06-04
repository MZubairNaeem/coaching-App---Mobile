import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/viewmodels/auth.dart';
import 'package:coachingapp/views/auth/signup.dart';
import 'package:coachingapp/views/coach_home.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/large_button_trasparent.dart';
import '../client_home.dart';
import 'forgetpass.dart';

class ClientLogin extends StatefulWidget {
  const ClientLogin({Key? key}) : super(key: key);

  @override
  State<ClientLogin> createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {
  var _key = "clientKey";
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Future<String?> _getUserType(String uid) async {
    DocumentSnapshot snapshot =
        await _database.collection('users').doc(uid).get();

    return snapshot.get('userType');
  }

  Future<void> _signinUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: _email.text, password: _pass.text);

      dynamic res = Auth().getUserDetails(user.user!.uid);
      var id = user.user!.uid;

      print(res);
      _key == 'coachKey'
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CoachHome()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ClientHome()));
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('Something went wrong. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Material(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.6,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors().primaryColor,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(50))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/fitnesslogo.svg',
                              alignment: Alignment.topCenter),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'FITNESS',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.38,
                    decoration: BoxDecoration(color: AppColors().primaryColor),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.38,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 0.035),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _key == 'coachKey'
                                      ? 'Coach Login'
                                      : 'Client Login',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors().primaryColor,
                                  ),
                                ),
                                Material(
                                  elevation: 3.0,
                                  shadowColor: AppColors().lightShadowColor,
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: TextField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                            Icons.person,
                                            color: AppColors().darKShadowColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: AppColors()
                                                  .lightShadowColor), //<-- SEE HERE
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color:
                                                  AppColors().lightShadowColor),
                                        ),
                                        hintText: 'Email',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                                Material(
                                  elevation: 3.0,
                                  shadowColor: AppColors().lightShadowColor,
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: TextField(
                                    controller: _pass,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            color: AppColors().darKShadowColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: AppColors()
                                                  .lightShadowColor), //<-- SEE HERE
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color:
                                                  AppColors().lightShadowColor),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgetPass()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 05),
                                      child: Text(
                                        "Forget Password",
                                        // textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors().primaryColor,
                                            letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                LargeButton(
                                    name: 'Login',
                                    onPressed: () async {
                                      // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      // sharedPreferences.setString('email', 'client');
                                      final SharedPreferences
                                          sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      _key == 'coachKey'
                                          ? sharedPreferences.setString(
                                              'key', 'coach')
                                          : sharedPreferences.setString(
                                              'key', 'client');
                                      _signinUser();
                                    }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account ? ",
                                      style: TextStyle(
                                          color: AppColors().darKShadowColor),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClientSignup(
                                                      keyValue: _key,
                                                    )));
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors().primaryColor),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: AppColors().lightShadowColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.08),
                                      child: Text(
                                        "Or",
                                        style: TextStyle(
                                            color: AppColors().darKShadowColor),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: AppColors().lightShadowColor,
                                      ),
                                    ),
                                  ],
                                ),
                                LargeButtonTransparent(
                                  name: "Continue With Phone",
                                  onPressed: () {},
                                ),
                                LargeButtonTransparent(
                                  name: _key == 'coachKey'
                                      ? 'Continue as Client'
                                      : 'Continue as Coach',
                                  onPressed: () {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => const CoachLogin()));
                                    setState(() {
                                      if (_key == "coachKey") {
                                        _key = "clientKey";
                                      } else {
                                        _key = "coachKey";
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
