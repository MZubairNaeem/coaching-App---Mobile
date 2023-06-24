import 'package:coachingapp/widgets/sub-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import '../../../utils/colors.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/snackbar.dart';

class CoachAppSub extends StatefulWidget {
  const CoachAppSub({super.key});

  @override
  State<CoachAppSub> createState() => _CoachAppSubState();
}

class _CoachAppSubState extends State<CoachAppSub> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomClipperPath(),
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                  decoration: BoxDecoration(
                    color: AppColors().primaryColor,
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Choose your Subscription",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Text(
                        "Choose your Subscription and get started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SubCard(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsePaypal(
                      sandboxMode: true,
                      clientId:
                          "AeRfsFBbxWC5ysDTazhuqPy18roGOfYIvB_AHPSXQB_JBamO5OWpacEwj-INbqwkkJDGGu1_QVBDgf2X",
                      secretKey:
                          "EIwq-8cS9DUnXTG0YF36QN3Xp8CWVtJr8M7J4mnPtxvMcULC4b0bECA69GgSCGyBvTFk2eClDdphvf9I",
                      returnURL: "https://samplesite.com/return",
                      cancelURL: "https://samplesite.com/cancel",
                      transactions: const [
                        {
                          "amount": {
                            "total": '150',
                            "currency": "USD",
                            "details": {
                              "subtotal": '150',
                              "shipping": '0',
                              "shipping_discount": 0
                            }
                          },
                          "description": "The payment transaction description.",
                          // "payment_options": {
                          //   "allowed_payment_method":
                          //       "INSTANT_FUqNDING_SOURCE"
                          // },
                          "item_list": {
                            "items": [
                              {
                                "name": "A demo product",
                                "quantity": 1,
                                "price": '150',
                                "currency": "USD"
                              }
                            ],
                          }
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {
                        showSnackBar(context, "onSuccess: $params");
                      },
                      onError: (error) {
                        showSnackBar(context, "onError: $error");
                      },
                      onCancel: (params) {
                        showSnackBar(context, "cancelled: $params");
                      }),
                ),
              );
            },
            price: "150\$",
            heading: "Plantinum Plan",
            noOfClients: "Unlimited",
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          SubCard(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UsePaypal(
                      sandboxMode: true,
                      clientId:
                          "AeRfsFBbxWC5ysDTazhuqPy18roGOfYIvB_AHPSXQB_JBamO5OWpacEwj-INbqwkkJDGGu1_QVBDgf2X",
                      secretKey:
                          "EIwq-8cS9DUnXTG0YF36QN3Xp8CWVtJr8M7J4mnPtxvMcULC4b0bECA69GgSCGyBvTFk2eClDdphvf9I",
                      returnURL: "https://samplesite.com/return",
                      cancelURL: "https://samplesite.com/cancel",
                      transactions: const [
                        {
                          "amount": {
                            "total": '50',
                            "currency": "USD",
                            "details": {
                              "subtotal": '50',
                              "shipping": '0',
                              "shipping_discount": 0
                            }
                          },
                          "description": "The payment transaction description.",
                          // "payment_options": {
                          //   "allowed_payment_method":
                          //       "INSTANT_FUqNDING_SOURCE"
                          // },
                          "item_list": {
                            "items": [
                              {
                                "name": "A demo product",
                                "quantity": 1,
                                "price": '50',
                                "currency": "USD"
                              }
                            ],
                          }
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {
                        showSnackBar(context, "onSuccess: $params");
                      },
                      onError: (error) {
                        showSnackBar(context, "onError: $error");
                      },
                      onCancel: (params) {
                        showSnackBar(context, "cancelled: $params");
                      }),
                ),
              );
            },
            price: "50\$",
            heading: "Gold Plan",
            noOfClients: "25",
          ),
        ],
      ),
    );
  }
}
