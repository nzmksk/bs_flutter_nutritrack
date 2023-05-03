// //This widget is to display nutrition info of the food based on the index

// //with nutrients endpoint but its showing null

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/models/models.dart';

class NutritionInfo extends StatefulWidget {
  final BrandedFoodModel foodItem;

  const NutritionInfo({required this.foodItem, Key? key}) : super(key: key);

  @override
  _NutritionInfoState createState() => _NutritionInfoState();
}

class _NutritionInfoState extends State<NutritionInfo> {
  late Map<String, dynamic> _nutriInfo = {};

  //api loading process variable
  bool _isLoading = false;

  //api details
  // String appId = dotenv.env['NUTRITIONIX_APP_ID']!;
  // String apiKey = dotenv.env['NUTRITIONIX_API_KEY']!;

  String appId = '077d62c7';
  String apiKey = '18e18988cc13c99074f8a95565dbc3d4';

  Future<void> getNutriInfo(String query) async {
    //before fetch data from api set state to true(processing data)
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

    //after fetch data from api set state to false(process end)
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
    getNutriInfo(widget.foodItem.foodName!);
  }

  //UI part
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.foodItem.foodName}'),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1.0,
                  // ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.network(
                  'https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/healthy-eating-ingredients-1296x728-header.jpg?w=1155&h=1528g',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  // border: Border.all(
                  //   width: 2.0,
                  //   color: Colors.black,
                  // ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Nutrition Facts',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      thickness: 5,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Amount per serving: ${_nutriInfo['serving_weight_grams']} g',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: const Text(
                        'Calories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      trailing: Text(
                        '${_nutriInfo['calories']} kcal',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title: const Text(
                        'Total Fat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${_nutriInfo['total_fat']} g',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title: const Text(
                        'Total Carbohydrate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${_nutriInfo['total_carbohydrate']} g',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title: const Text(
                        'Protein',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${_nutriInfo['protein']} g',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
