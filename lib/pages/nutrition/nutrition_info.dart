import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../../custom_widgets/custom_widgets.dart';
import '../../models/models.dart';

class NutritionInfo extends StatefulWidget {
  final BrandedFoodItemModel brandedFoodItem;

  const NutritionInfo({required this.brandedFoodItem, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NutritionInfoState createState() => _NutritionInfoState();
}

class _NutritionInfoState extends State<NutritionInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _amountController =
      TextEditingController(text: '1.00');
  String? selectedMeal;
  num amountToDisplay = 1;

  late List<BrandedFoodNutritionModel> brandedFoodNutrition = [];

  bool _isLoading = false;

  String appId = dotenv.env['NUTRITIONIX_APP_ID3']!;
  String apiKey = dotenv.env['NUTRITIONIX_API_KEY3']!;

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

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body)['foods'];
        setState(() {
          brandedFoodNutrition = (data as List)
              .map((food) => BrandedFoodNutritionModel.fromJson(food))
              .toList();
        });
        break;
      case 400:
        throw Exception('Invalid request/input parameters');
      case 401:
        throw Exception(
            'Invalid auth keys / Reaching API limit / Missing tokens');
      case 404:
        throw Exception('Data not found');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Unknown error');
    }
  }

  Stream<num> amountListener(TextEditingController controller) async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (controller.value.text.isNotEmpty &&
          (num.tryParse(controller.value.text) ?? 0) > 0) {
        yield num.parse(controller.value.text);
      }
    }
  }

  @override
  void initState() {
    getNutritionInfo(widget.brandedFoodItem.itemId!);
    _amountController.addListener(() {
      if (_amountController.value.text.isNotEmpty &&
          (num.tryParse(_amountController.value.text) ?? 0) > 0) {
        setState(() {
          amountToDisplay = num.parse(_amountController.value.text);
        });
      } else if (_amountController.value.text.isEmpty ||
          (num.tryParse(_amountController.value.text) ?? 0) < 0.01) {
        setState(() {
          amountToDisplay = 1;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
                      offset: const Offset(0, 3)
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
                            return const Center(
                              child: Text('Could not load information'),
                            );
                          } else {
                            final calories =
                                foodItem.totalCalories! * amountToDisplay;
                            final totalFat =
                                foodItem.totalFat! * amountToDisplay;
                            final saturatedFat =
                                foodItem.saturatedFat! * amountToDisplay;
                            final cholesterol =
                                foodItem.cholesterol! * amountToDisplay;
                            final totalCarbohydrates =
                                foodItem.totalCarbohydrates! * amountToDisplay;
                            final dietaryFiber =
                                foodItem.dietaryFiber! * amountToDisplay;
                            final sugars = foodItem.sugars! * amountToDisplay;
                            final sodium = foodItem.sodium! * amountToDisplay;
                            final protein = foodItem.protein! * amountToDisplay;
                            final potassium =
                                foodItem.potassium! * amountToDisplay;

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
                                    '$totalFat g',
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
                                    '$saturatedFat g',
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
                                    '$cholesterol mg',
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
                                    '$sodium mg',
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
                                    '$totalCarbohydrates g',
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
                                    '$dietaryFiber g',
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
                                    '$sugars g',
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
                                    '$protein g',
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
                                    '$potassium mg',
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
                              _mealController.text = meal?.label ?? '';
                              setState(() {
                                selectedMeal = _mealController.text;
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
                              validator: (value) {
                                if (value == '' ||
                                    (num.tryParse(value!) ?? 0) < 0.01) {
                                  return 'Amount cannot be 0 or empty.';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              selectedMeal ??= MealLabel.breakfast.label;
                              addCalorie(
                                  foodItem, selectedMeal!, amountToDisplay);
                              const snackBar = SnackBar(
                                content: Text('Added to calorie intake!'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Add to Calorie Intake'),
                          ),
                        ),
                      ),
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

Future addCalorie(BrandedFoodNutritionModel foodItem, String selectedMeal,
    num servingAmount) async {
  // Reference to document
  final docFoodLog = FirebaseFirestore.instance
      .collection('calorie-intake')
      .doc('${foodItem.itemId}');

  final json = foodItem.toJson();
  json['meal'] = selectedMeal;
  json['serving_amount'] = servingAmount;

  // Create document and write data to Firebase
  await docFoodLog.set(json);
}
