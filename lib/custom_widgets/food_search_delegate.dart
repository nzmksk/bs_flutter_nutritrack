import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../pages/pages.dart';

class FoodSearchDelegate extends SearchDelegate {
  Future<FoodListModel> foodSearchDelegate() async {
    String appId = dotenv.env['NUTRITIONIX_APP_ID']!;
    String apiKey = dotenv.env['NUTRITIONIX_API_KEY']!;
    String apiUrl =
        'https://trackapi.nutritionix.com/v2/search/instant?query=$query';

    http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-app-id': appId,
        'x-app-key': apiKey,
      },
    );

    final data = jsonDecode(response.body);
    return FoodListModel.fromJson(data);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          icon: const Icon(Icons.clear_outlined),
          onPressed: () {
            query.isEmpty ? close(context, null) : query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '') {
      return FutureBuilder(
        future: foodSearchDelegate(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.brandedFood?.length,
              itemBuilder: (context, index) {
                final brandedFoodItem = snapshot.data!.brandedFood![index];
                return ListTile(
                  title: Text(brandedFoodItem.foodName!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NutritionInfo(brandedFoodItem: brandedFoodItem),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
