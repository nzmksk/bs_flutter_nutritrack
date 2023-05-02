import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/models/models.dart';

class FoodSearchDelegate extends SearchDelegate {
  Future<NutritionModel> foodSearchDelegate() async {
    String appId = '077d62c7';
    String apiKey = '18e18988cc13c99074f8a95565dbc3d4';
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
    return NutritionModel.fromJson(data);
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
              itemCount: snapshot.data!.commonFood?.length,
              itemBuilder: (context, index) {
                final commonFoodItem = snapshot.data!.commonFood![index];
                return ListTile(
                  title: Text(commonFoodItem.foodName!),
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
