//This widget is to display nutrition info of the food based on the index




//with nutrients endpoint but its showing null

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NutritionInfo extends StatefulWidget {
  final dynamic foodItem;

  const NutritionInfo({required this.foodItem, Key? key}) : super(key: key);

  @override
  _NutritionInfoState createState() => _NutritionInfoState();
}

class _NutritionInfoState extends State<NutritionInfo> {
  late Map<String, dynamic> _nutriInfo = {};
  bool _isLoading = false;

  String appId = '077d62c7';
  String apiKey = '18e18988cc13c99074f8a95565dbc3d4';

  Future<void> getNutriInfo(String query) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://trackapi.nutritionix.com/v2/natural/nutrients'),
      headers: {
        'x-app-id': appId,
        'x-app-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'query': query,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _nutriInfo = data;
      });
    } else {
      throw Exception('No data found');
    }
  }

  @override
  void initState() {
    super.initState();
    getNutriInfo(widget.foodItem['food_name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodItem['food_name']),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serving size: ${_nutriInfo['serving_weight_grams']} g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Calories: ${_nutriInfo['calories']} kcal',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Fat: ${_nutriInfo['total_fat']} g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Carbohydrate: ${_nutriInfo['total_carbohydrate']} g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Protein: ${_nutriInfo['protein']} g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

// Template I create for nutrition facts

// class NutritionInfo extends StatelessWidget {
//   final dynamic foodItem;
//   const NutritionInfo({Key? key, required this.foodItem}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nutrition Info of ${foodItem['food_name']}'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding (
//           padding: const EdgeInsets.all(25.0),
//           child: Container(
//              padding: EdgeInsets.fromLTRB(10, 10, 10,0),
//              decoration: BoxDecoration (
//               border: Border.all(
//                  color: Colors.black,
//                  width: 2,

//               ),
//                borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Image(
//                  image: NetworkImage('https://img.freepik.com/free-photo/top-view-table-full-delicious-food-composition_23-2149141352.jpg'),

//                 ),
//                  SizedBox(height: 15.0),
//                 Text(
//                   'Nutrition Facts',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Divider(thickness: 5,color: Colors.black,),

//                // SizedBox(height: 16.0),
//                Text(
//                   'Amount Per Serving',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 ListTile(
//                   dense:true,
//                   title: Text(

//                     'Calories',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),

//                   ),
//                   trailing: Text(
//                     '120 cal',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),
//                   ),
//                 ),
//                 Divider(thickness: 2,color: Colors.black,),
//                 ListTile(
//                   dense:true,
//                   title: Text(
//                     'Total Fat',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   trailing: Text(
//                     '3g',
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Divider(thickness: 1,color: Colors.black,),
//                 ListTile(
//                   dense:true,
//                   title: Text(
//                     'Saturated Fat',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   trailing: Text(
//                     '1g',
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                  Divider(thickness: 1,color: Colors.black,),
//                  SizedBox(height: 0),
//                 ListTile(
//                   dense:true,
//                   title: Text(
//                     'Cholesterol',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   trailing: Text(
//                     '15mg',
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Divider(thickness: 5,color: Colors.black,),
//                 Text(
//                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
//                   'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
//               ],
//             ),
//           ),

//         )

//       ),
//     );
//   }
// }


































   