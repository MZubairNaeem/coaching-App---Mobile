import 'package:coachingapp/viewmodels/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../widgets/large_button_blue.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final _email = TextEditingController();
  bool _isLoading = false;

  Future<void> _forgetpass() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var res = await Auth().forgetPass(email: _email.text);
      if(res == 'Success'){
        Navigator.of(context).pop();
      }
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
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Material(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                          borderRadius:
                          const BorderRadius.only(bottomRight: Radius.circular(50))),
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
                      child:  _isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          :Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors().primaryColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight*0.05),
                            child: Material(
                              elevation: 3.0,
                              shadowColor: AppColors().lightShadowColor,
                              borderRadius: BorderRadius.circular(50.0),
                              child: TextField(
                                controller: _email,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors().darKShadowColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(width: 1, color: AppColors().lightShadowColor), //<-- SEE HERE
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(width: 1, color: AppColors().lightShadowColor),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ),
                          LargeButton(
                              name: 'Send reset mail',
                              onPressed: (){
                                _forgetpass();
                              }
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
