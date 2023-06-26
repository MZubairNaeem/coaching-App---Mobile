// import 'package:flutter/material.dart';

// import '../utils/colors.dart';

// class SubscriptionDialog extends StatefulWidget {
//   String? price;
//   String? time ;
//   String? description;
//   String? subscriptionType ;
//   SubscriptionDialog({super.key, this.price, this.time, this.description, this.subscriptionType});

//   @override
//   State<SubscriptionDialog> createState() => _SubscriptionDialogState();
// }

// class _SubscriptionDialogState extends State<SubscriptionDialog> {
//   String? dropdownValue;
//   List<String> item = [
//     'Platinum',
//     'Gold',
//     'Silver',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return AlertDialog(
//       title: Text('Add Subscription Details'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             decoration: InputDecoration(labelText: 'Price'),
//             onChanged: (value) {
//               setState(() {
//                 price = value;
//               });
//             },
//           ),
//           TextField(
//             decoration: InputDecoration(labelText: 'Subscription Timeline'),
//             onChanged: (value) {
//               setState(() {
//                 time = value;
//               });
//             },
//           ),
//           TextField(
//             decoration: InputDecoration(labelText: 'Subscription Description'),
//             onChanged: (value) {
//               setState(() {
//                 description = value;
//               });
//             },
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Material(
//             elevation: 3.0,
//             shadowColor: AppColors().lightShadowColor,
//             borderRadius: BorderRadius.circular(50.0),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   icon: Icon(
//                     Icons.location_on,
//                     color: AppColors().darKShadowColor,
//                   ),
//                   hint: Text('Select Subscription Type'),
//                   items: item
//                       .map((e) => DropdownMenuItem(
//                             value: e,
//                             child: Text(e),
//                           ))
//                       .toList(),
//                   onChanged: (val) {
//                     setState(() {
//                       dropdownValue = val as String;
                      
//                       print(val.toString());
//                     });
//                   },
//                   value: dropdownValue,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             // Perform the desired action with the entered subscription details
//             print('Price: $price, Time: $time, Description: $description');
//             Navigator.pop(context); // Close the dialog
//           },
//           child: Text('Add'),
//         ),
//       ],
//     );
//   }
// }
