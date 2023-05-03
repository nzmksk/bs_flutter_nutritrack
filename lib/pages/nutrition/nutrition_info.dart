

import 'dart:convert';
import 'package:bs_flutter_nutritrack/cubits/cubits.dart';
import 'package:bs_flutter_nutritrack/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NutritionInfo extends StatefulWidget {
  final dynamic foodItem;

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
    getNutriInfo(widget.foodItem['food_name']);
  }

  //UI part
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Info of ${widget.foodItem['food_name']}'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Container(
                    child: Image.network(
                      'https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/healthy-eating-ingredients-1296x728-header.jpg?w=1155&h=1528g',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                
                Container(
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
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
                      Text(
                        'Nutrition Facts',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.black,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Amount per serving: ${_nutriInfo['serving_weight_grams']} g',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          'Calories',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        trailing: Text(
                          '${_nutriInfo['calories']} kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          'Total Fat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          '${_nutriInfo['total_fat']} g',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          'Total Carbohydrate',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          '${_nutriInfo['total_carbohydrate']} g',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      
                      ListTile(
                        dense: true,
                        title: Text(
                          'Protein',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          '${_nutriInfo['protein']} g',
                          style: TextStyle(
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
      ),
    );
  }
}
