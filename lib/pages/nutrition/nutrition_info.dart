import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../models/models.dart';

enum MealLabel {
  breakfast('Breakfast'),
  lunch('Lunch'),
  dinner('Dinner');

  const MealLabel(this.label);
  final String label;
}

class NutritionInfo extends StatefulWidget {
  final BrandedFoodItemModel brandedFoodItem;

  const NutritionInfo({required this.brandedFoodItem, Key? key})
      : super(key: key);

  @override
  _NutritionInfoState createState() => _NutritionInfoState();
}

class _NutritionInfoState extends State<NutritionInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _amountController =
      TextEditingController(text: '1.00');
  MealLabel? selectedMeal;
  num amountToDisplay = 1;

  late List<BrandedFoodNutritionModel> brandedFoodNutrition = [];

  bool _isLoading = false;

  String appId = dotenv.env['NUTRITIONIX_APP_ID']!;
  String apiKey = dotenv.env['NUTRITIONIX_API_KEY']!;

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

  Stream<num> amountListener(TextEditingController controller) async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield num.parse(controller.value.text);
    }
  }

  @override
  void initState() {
    getNutritionInfo(widget.brandedFoodItem.itemId!);
    _amountController.addListener(() {
      setState(() {
        amountToDisplay = num.parse(_amountController.value.text);
      });
    });
    super.initState();
  }

  //UI part
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<MealLabel>> mealEntries =
        <DropdownMenuEntry<MealLabel>>[];
    for (final MealLabel meal in MealLabel.values) {
      mealEntries
          .add(DropdownMenuEntry<MealLabel>(value: meal, label: meal.label));
    }

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
                              foodItem.servingUnit == 'g'
                                  ? 'Serving size: ${foodItem.servingWeight} g'
                                  : 'Serving size: ${foodItem.servingQuantity} ${foodItem.servingUnit}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<num>(
                        stream: amountListener(_amountController),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Column(
                              children: [
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            );
                          } else {
                            final multipliers = snapshot.data ?? 1;
                            final calories =
                                foodItem.totalCalories! * multipliers;

                            return Column(
                              children: [
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
                                    '$calories kcal',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
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
                                  indent: 16,
                                  endIndent: 16,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownMenu<MealLabel>(
                            initialSelection: MealLabel.breakfast,
                            controller: _mealController,
                            label: const Text('Meal'),
                            dropdownMenuEntries: mealEntries,
                            onSelected: (MealLabel? meal) {
                              setState(() {
                                selectedMeal = meal;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Amount'),
                                hintText: '0.00',
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                DecimalTextInputFormatter(decimalRange: 2),
                              ],
                              controller: _amountController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addCalorie(foodItem);
                        const snackBar = SnackBar(
                          content: Text('Added to calorie intake!'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Text('Add Food'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

Future addCalorie(BrandedFoodNutritionModel foodItem) async {
  // Reference to document
  final docAddCalorie =
      FirebaseFirestore.instance.collection('calorie-intake').doc();

  // Create document and write data to Firebase
  await docAddCalorie.set(foodItem.toJson());
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert((decimalRange == null || decimalRange > 0));

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains('.') &&
          value.substring(value.indexOf('.') + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == '.') {
        truncated = '0.';

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
