import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../pages.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BrandedFoodNutritionModel>>(
      stream: readFoodLog(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final foodItemList = snapshot.data;

          return ListView(
            children: foodItemList!
                .map((foodItem) => buildFoodItem(context, foodItem))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong! ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildFoodItem(
      BuildContext context, BrandedFoodNutritionModel foodItem) {
    return Card(
      child: ListTile(
        title: Text('${foodItem.foodName!} (x${foodItem.servingAmount})'),
        subtitle: Text(
          '${foodItem.totalCalories! * foodItem.servingAmount!} kcal intake',
          style: const TextStyle(color: Colors.green),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NutritionDetailsPage(foodItem: foodItem)));
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
          onPressed: () {},
        ),
      ),
    );
  }

  Stream<List<BrandedFoodNutritionModel>> readFoodLog() =>
      FirebaseFirestore.instance.collection('calorie-intake').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => BrandedFoodNutritionModel.fromJson(doc.data()))
              .toList());
}
