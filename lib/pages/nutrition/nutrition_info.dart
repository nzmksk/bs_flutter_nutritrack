import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/models.dart';

class NutritionInfo extends StatefulWidget {
  final BrandedFoodItemModel brandedFoodItem;

  const NutritionInfo({required this.brandedFoodItem, Key? key})
      : super(key: key);

  @override
  _NutritionInfoState createState() => _NutritionInfoState();
}

class _NutritionInfoState extends State<NutritionInfo> {
  late List<BrandedFoodNutritionModel> brandedFoodNutrition = [];

  bool _isLoading = false;

  String appId = '077d62c7';
  String apiKey = '18e18988cc13c99074f8a95565dbc3d4';

  Future<void> getNutritionInfo(String itemId) async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await http.get(
      Uri.parse(
          'https://trackapi.nutritionix.com/v2/search/item?nix_item_id=$itemId'),
      headers: {
        'x-app-id': appId,
        'x-app-key': apiKey,
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['foods'];
      print(data);
      setState(() {
        brandedFoodNutrition = (data as List)
            .map((food) => BrandedFoodNutritionModel.fromJson(food))
            .toList();
      });
    } else {
      throw Exception('No data found');
    }
  }

  @override
  void initState() {
    super.initState();
    getNutritionInfo(widget.brandedFoodItem.itemId!);
  }

  //UI part
  @override
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      BrandedFoodNutritionModel foodItem = brandedFoodNutrition[0];
      return Scaffold(
        appBar: AppBar(
          title: Text('${foodItem.foodName}'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                  child: Center(
                    child: Image.network(
                      '${foodItem.imageUrl}',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
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
                        'Amount per serving: ${foodItem.servingWeight} g',
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
                          '${foodItem.totalCalories} kcal',
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
                          '${foodItem.totalFat} g',
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
                          '${foodItem.totalCarbohydrates} g',
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
                          '${foodItem.protein} g',
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
}
