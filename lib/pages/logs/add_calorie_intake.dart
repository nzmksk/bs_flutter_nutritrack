import 'package:flutter/material.dart';

class AddCalorieIntake extends StatefulWidget {
  const AddCalorieIntake({super.key});

  @override
  State<AddCalorieIntake> createState() => _AddCalorieIntakeState();
}

class _AddCalorieIntakeState extends State<AddCalorieIntake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add calorie log'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Serving Size',
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlinedButton myBtn() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(200, 50),
      ),
      child: const Text(
        'Add',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
