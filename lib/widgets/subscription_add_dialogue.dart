import 'package:flutter/material.dart';

class SubscriptionDialog extends StatefulWidget {
  const SubscriptionDialog({super.key});

  @override
  State<SubscriptionDialog> createState() => _SubscriptionDialogState();
}

class _SubscriptionDialogState extends State<SubscriptionDialog> {
  @override
  String price = '';
  String time = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Subscription Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Price'),
            onChanged: (value) {
              setState(() {
                price = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Subscription Time'),
            onChanged: (value) {
              setState(() {
                time = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Subscription Description'),
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Perform the desired action with the entered subscription details
            print('Price: $price, Time: $time, Description: $description');
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
