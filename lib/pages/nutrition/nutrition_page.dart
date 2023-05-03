import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../pages.dart';
import '../../models/models.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  late List<BrandedFoodItemModel> _fetchFoodList = [];
  bool _isLoading = false;

  String appId = dotenv.env['NUTRITIONIX_APP_ID']!;
  String apiKey = dotenv.env['NUTRITIONIX_API_KEY']!;

  Future<void> nutriSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await http.get(
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
      final data = jsonDecode(response.body)['branded'];
      setState(() {
        _fetchFoodList = (data as List)
            .map((food) => BrandedFoodItemModel.fromJson(food))
            .toList();
      });
    } else {
      throw Exception('No data found');
    }
  }

//UI part
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for food:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                onSubmitted: nutriSearch,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_fetchFoodList.isEmpty)
              const Center(
                child: Text('No results found.'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _fetchFoodList.length,
                  itemBuilder: (context, index) {
                    final foodItem = _fetchFoodList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NutritionInfo(brandedFoodItem: foodItem),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:
                              const BorderSide(width: 3, color: Colors.indigo),
                        ),
                        color: Colors.grey[200],
                        //add shadow effect
                        elevation: 1.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      width: 2, color: Colors.black),
                                ),
                                child: Image.network(
                                  foodItem.imageUrl!,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foodItem.foodName!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      foodItem.servingUnit == null
                                          ? '${foodItem.totalCalories} kcal (${foodItem.servingQuantity})'
                                          : '${foodItem.totalCalories} kcal (${foodItem.servingQuantity} ${foodItem.servingUnit})',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
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
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
