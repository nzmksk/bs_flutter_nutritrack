import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'nutrition_info.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  late List<dynamic> _nutriSearchList = [];
  bool _isLoading = false;

  String appId = '077d62c7';
  String apiKey = '18e18988cc13c99074f8a95565dbc3d4';

  Future<void> nutriSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          'https://trackapi.nutritionix.com/v2/search/instant?query=$query'),
      headers: {
        'x-app-id': appId,
        'x-app-key': apiKey,
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['common'];
      // print(response.body);
      setState(() {
        _nutriSearchList = data;
      });
    } else {
      throw Exception('No data found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search The Food'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                onSubmitted: nutriSearch,
                decoration: const InputDecoration(
                  hintText: 'Search the food here',
                  contentPadding: EdgeInsets.all(16),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.black)),
                ),
              ),
              Container(
                decoration: _nutriSearchList.isNotEmpty
                    ? BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        //borderRadius: BorderRadius.circular(8),
                      )
                    : null,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 300,
                        child: ListView.separated(
                          itemCount: _nutriSearchList.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final foodItem = _nutriSearchList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NutritionInfo(foodItem: foodItem)),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: NetworkImage(
                                            foodItem['photo']['thumb']),
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(foodItem['food_name'],
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            if (foodItem['serving_unit'] !=
                                                null)
                                              Text(foodItem['serving_unit'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//This code show result without image

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'nutrition_info.dart';

// class NutritionPage extends StatefulWidget {
//   const NutritionPage({Key? key}) : super(key: key);

//   @override
//   State<NutritionPage> createState() => _NutritionPageState();
// }

// class _NutritionPageState extends State<NutritionPage> {
//   late List<dynamic> _nutriSearchList = [];
//   bool _isLoading = false;

//   String appId = '077d62c7';
//   String apiKey = '18e18988cc13c99074f8a95565dbc3d4';

//   Future<void> nutriSearch(String query) async {
//     setState(() {
//       _isLoading = true;
//     });

//     final response = await http.get(
//       Uri.parse(
//           'https://trackapi.nutritionix.com/v2/search/instant?query=$query'),
//       headers: {
//         'x-app-id': appId,
//         'x-app-key': apiKey,
//       },
//     );

//     setState(() {
//       _isLoading = false;
//     });

//     if (response.statusCode == 200) {
//      final data = json.decode(response.body)['common'];
//       // print(response.body);
//       setState(() {
//        _nutriSearchList = data;
//       });
//     } else {
//       throw Exception('No data found');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search The Food'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
           
//             children: [
//               TextField(
//                 onSubmitted: nutriSearch,
//                 decoration: const InputDecoration(
//                   hintText: 'Search for a food',
//                   contentPadding: EdgeInsets.all(16),
//                   // enabledBorder: OutlineInputBorder(
//                   //   borderSide: BorderSide(width: 3, color: Colors.black),
//                   // ),
//                   border: OutlineInputBorder(borderSide: BorderSide(width: 3 , color: Colors.black))
//                 ),
//               ),
              
//               Container(
//                 decoration:_nutriSearchList.isNotEmpty
//                   ? BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                   //borderRadius: BorderRadius.circular(8),
//                   ):null,
//                  child: _isLoading
//                 ? const CircularProgressIndicator()
//                   : SizedBox(
//                       height:200,
//                       child: ListView.separated(
//                        itemCount: _nutriSearchList.length,
//                        separatorBuilder: (context, index) => Divider(),
//                        itemBuilder: (context, index) {
//                           final foodItem = _nutriSearchList[index];
//                           return ListTile(
//                             leading: Image(
//                               image: NetworkImage(foodItem['photo']['thumb']),
//                               width: 50,
//                               height: 50,
//                             ),
//                             title: Text(foodItem['food_name']),
//                             // onTap: () {
//                             //   Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) =>
//                             //             NutritionInfo(foodItem:foodItem)),
//                             //   );
//                             //   // nutriSearchList.length,
                              
//                             // },
//                           );
                         
//                         },
//                       ),
                      
//                    )   
              
//                ),
             
//             ]
//           ),
//         ),
//       ),
//     );
//   }
// }

//This code show result with image
