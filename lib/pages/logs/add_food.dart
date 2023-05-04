import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/custom_widgets.dart';

class AddFood extends StatelessWidget {
  const AddFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add or Search Food'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: FoodSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                IconData(0xf586,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //Calorie textfield
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Total Calories',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    //meal type dropdown
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: DropdownButtonFormField<String>(
                        //decoration
                        decoration: InputDecoration(
                          labelText: 'Meal Type',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),

                        items: const [
                          DropdownMenuItem(
                            value: 'breakfast',
                            child: Text('Breakfast'),
                          ),
                          DropdownMenuItem(
                            value: 'lunch',
                            child: Text('Lunch'),
                          ),
                          DropdownMenuItem(
                            value: 'dinner',
                            child: Text('Dinner'),
                          ),
                        ],
                        onChanged: (value) {
                          // Do something with the selected value
                        },
                      ),
                    ),
                    //add button
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        backgroundColor: const Color.fromARGB(178, 73, 86, 160),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Instant Add Food',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
