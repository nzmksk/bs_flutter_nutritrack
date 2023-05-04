// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../custom_widgets/custom_widgets.dart';

// class AddFood extends StatelessWidget {
//   const AddFood({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Food'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: IconButton(
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: SearchNutritionInfo(),
//                 );
//               },
//               icon: const Icon(Icons.search_outlined),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 IconData(0xf586,
//                     fontFamily: CupertinoIcons.iconFont,
//                     fontPackage: CupertinoIcons.iconFontPackage),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: OutlinedButton(
//                 onPressed: () {
//                   showSearch(
//                     context: context,
//                     delegate: SearchNutritionInfo(),
//                   );
//                 },
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: const Size(200, 50),
//                 ),
//                 child: const Text(
//                   'Search Food',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: OutlinedButton(
//                 onPressed: () {},
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: const Size(200, 50),
//                 ),
//                 child: const Text(
//                   'Scan Barcode',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: OutlinedButton(
//                 onPressed: () {},
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: const Size(200, 50),
//                 ),
//                 child: const Text(
//                   'Quick Add',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class AddFood extends StatelessWidget {
  const AddFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //Title
          children: [
            const SizedBox(height: 24),
            const Text(
              'Your Meal Intake',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            //Image container
            const SizedBox(height: 16),
            Container(
              height: 350,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://thumbs.dreamstime.com/b/veidai-195638497.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //input container
            SizedBox(height: 10),
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Calories',
                        labelStyle: TextStyle(
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
                    //meal type dropdown
                    const SizedBox(height: 16),
                    // DropdownButtonFormField<String>(
                    //   //decoration
                    //   decoration: InputDecoration(
                    //     labelText: 'Meal Type',
                    //     labelStyle: TextStyle(
                    //       color: Colors.grey,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         width: 2,
                    //         color: Colors.grey.withOpacity(0.5),
                    //       ),
                    //       borderRadius: BorderRadius.circular(50.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         width: 2,
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //       borderRadius: BorderRadius.circular(50.0),
                    //     ),
                    //   ),
                      
                    //   items: const [
                    //     DropdownMenuItem(
                    //       value: 'breakfast',
                    //       child: Text('Breakfast'),
                    //     ),
                    //     DropdownMenuItem(
                    //       value: 'lunch',
                    //       child: Text('Lunch'),
                    //     ),
                    //     DropdownMenuItem(
                    //       value: 'dinner',
                    //       child: Text('Dinner'),
                    //     ),
                    //   ],
                    //   onChanged: (value) {
                    //     // Do something with the selected value
                    //   },
                    // ),
                    //add button
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Add Food',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
