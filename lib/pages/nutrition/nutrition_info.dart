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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
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
                ),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              foodItem.servingUnit != 'g'
                                  ? 'Serving size: ${foodItem.servingQuantity} g'
                                  : 'Serving size: ${foodItem.servingQuantity} / ${foodItem.servingUnit}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              dense: true,
                              title: const Text(
                                'Total Calories',
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
                                'Saturated fat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${foodItem.saturatedFat} g',
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
                                'Cholesterol',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${foodItem.cholesterol} mg',
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
                                'Sodium',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${foodItem.sodium} mg',
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
                                'Total Carbohydrates',
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
                                'Dietary fiber',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${foodItem.dietaryFiber} g',
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
                                'Sugars',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${foodItem.sugars} g',
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
                            const Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                            ListTile(
                              dense: true,
                              title: const Text(
                                'Potassium',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${foodItem.potassium} mg',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Add Food'),
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
}
