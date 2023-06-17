import 'package:coachingapp/utils/colors.dart';
import 'package:coachingapp/widgets/large_button_blue.dart';
import 'package:coachingapp/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../viewmodels/auth.dart';
import 'login.dart';

class ClientSignup extends StatefulWidget {
  final String keyValue;
  const ClientSignup({Key? key, required this.keyValue}) : super(key: key);
  @override
  State<ClientSignup> createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  int testYear = 1980;
  int testMonth = 0;
  int testDay = 0;

  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Function(String)? onLogin;

  Future<String?> _getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  void _saveUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
  }

  Future<void> _signupUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      var res = await Auth().signUpUser(
          firstName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          location: _locationController.text,
          dateOfBirth: _dateOfBirthController.text,
          phoneNumber: _phoneNumberController.text,
          userType: widget.keyValue,
          photoUrl:
              "https://funylife.in/wp-content/uploads/2023/04/58_Cute-Girl-Pic-WWW.FUNYLIFE.IN_-1-1024x1024.jpg");
      if (res == 'Success') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                      child: Form(
                        key: _formKey,
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.keyValue == 'coachKey'
                                        ? 'Coach  Sign up'
                                        : 'Client Sign up',
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
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.person,
                                              color:
                                                  AppColors().darKShadowColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors()
                                                    .primaryColor), //<-- SEE HERE
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
                                                color: AppColors()
                                                    .lightShadowColor),
                                          ),
                                          hintText: 'First name',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  Material(
                                    elevation: 3.0,
                                    shadowColor: AppColors().lightShadowColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.email,
                                              color:
                                                  AppColors().darKShadowColor,
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
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors()
                                                    .primaryColor), //<-- SEE HERE
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColors()
                                                    .lightShadowColor),
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
                                      controller: _dateOfBirthController,
                                      readOnly: true,
                                      onTap: () async {
                                        var date = await showDatePicker(
                                          
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1975),
                                          lastDate: DateTime.now(),
                                          
                                        );
                                        setState(() {
                                          if (date != null) {
                                            var myYear =
                                                int.parse('${date.year}');
                                            testYear = myYear;

                                            var myMonth =
                                                int.parse('${date.month}');
                                            testMonth = myMonth;

                                            var myDay =
                                                int.parse('${date.day}');
                                            testDay = myDay;

                                            _dateOfBirthController.text =
                                                "${date.day}/${date.month}/${date.year}";
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.calendar_month,
                                              color:
                                                  AppColors().darKShadowColor,
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
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors()
                                                    .primaryColor), //<-- SEE HERE
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColors()
                                                    .lightShadowColor),
                                          ),
                                          hintText: 'Date of Birth',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  Material(
                                    elevation: 3.0,
                                    shadowColor: AppColors().lightShadowColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: TextField(
                                      controller: _locationController,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.location_on,
                                              color:
                                                  AppColors().darKShadowColor,
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
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors()
                                                    .primaryColor), //<-- SEE HERE
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColors()
                                                    .lightShadowColor),
                                          ),
                                          hintText: 'City',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  Material(
                                    elevation: 3.0,
                                    shadowColor: AppColors().lightShadowColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: TextField(
                                      controller: _phoneNumberController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.phone,
                                              color:
                                                  AppColors().darKShadowColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors()
                                                    .primaryColor), //<-- SEE HERE
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
                                                color: AppColors()
                                                    .lightShadowColor),
                                          ),
                                          hintText: '(+62) 812 0101 0101',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  Material(
                                    elevation: 3.0,
                                    shadowColor: AppColors().lightShadowColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _obscurePassword =
                                                      !_obscurePassword;
                                                });
                                              },
                                              icon: Icon(
                                                _obscurePassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color:
                                                    AppColors().darKShadowColor,
                                              ),
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
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors()
                                                    .primaryColor), //<-- SEE HERE
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColors()
                                                    .lightShadowColor),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  Text(
                                    "Agree term & condition",
                                    style: TextStyle(
                                        color: AppColors().darKShadowColor),
                                  ),
                                  LargeButton(
                                    name: 'Sign Up',
                                    onPressed: () async {
                                      _signupUser();
                                    },
                                  ),
                                ],
                              ),
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
