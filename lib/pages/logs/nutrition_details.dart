import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../custom_widgets/custom_widgets.dart';
import '../../models/models.dart';

class NutritionDetailsPage extends StatefulWidget {
  final BrandedFoodNutritionModel foodItem;

  const NutritionDetailsPage({super.key, required this.foodItem});

  @override
  State<NutritionDetailsPage> createState() => _NutritionDetailsPageState();
}

class _NutritionDetailsPageState extends State<NutritionDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mealController = TextEditingController();
  late final TextEditingController _amountController =
      TextEditingController(text: '${widget.foodItem.servingAmount}');
  late String? selectedMeal = widget.foodItem.meal;
  late num amountToDisplay = widget.foodItem.servingAmount!;

  MealLabel initialDropDownValue() {
    switch (widget.foodItem.meal) {
      case 'Lunch':
        return MealLabel.lunch;
      case 'Dinner':
        return MealLabel.dinner;
      case 'Breakfast':
      default:
        return MealLabel.breakfast;
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

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<MealLabel>> mealEntries =
        <DropdownMenuEntry<MealLabel>>[];
    for (final MealLabel meal in MealLabel.values) {
      mealEntries
          .add(DropdownMenuEntry<MealLabel>(value: meal, label: meal.label));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodItem.foodName!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.clear_outlined),
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
                  '${widget.foodItem.imageUrl}',
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
                            widget.foodItem.servingUnit == 'g'
                                ? 'Serving size: ${widget.foodItem.servingWeight} g'
                                : 'Serving size: ${widget.foodItem.servingQuantity} ${widget.foodItem.servingUnit}',
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
                              widget.foodItem.totalCalories! * amountToDisplay;
                          final totalFat =
                              widget.foodItem.totalFat! * amountToDisplay;
                          final saturatedFat =
                              widget.foodItem.saturatedFat! * amountToDisplay;
                          final cholesterol =
                              widget.foodItem.cholesterol! * amountToDisplay;
                          final totalCarbohydrates =
                              widget.foodItem.totalCarbohydrates! *
                                  amountToDisplay;
                          final dietaryFiber =
                              widget.foodItem.dietaryFiber! * amountToDisplay;
                          final sugars =
                              widget.foodItem.sugars! * amountToDisplay;
                          final sodium =
                              widget.foodItem.sodium! * amountToDisplay;
                          final protein =
                              widget.foodItem.protein! * amountToDisplay;
                          final potassium =
                              widget.foodItem.potassium! * amountToDisplay;
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
                          initialSelection: initialDropDownValue(),
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
                            keyboardType: const TextInputType.numberWithOptions(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text('Delete'),
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                updateCalorie(widget.foodItem, selectedMeal!,
                                    amountToDisplay);
                              }
                              const snackBar = SnackBar(
                                content: Text('Calorie log updated!'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future updateCalorie(BrandedFoodNutritionModel foodItem, String selectedMeal,
    num servingAmount) async {
  // Reference to document
  final docFoodLog = FirebaseFirestore.instance
      .collection('calorie-intake')
      .doc('${foodItem.itemId}');

  final json = foodItem.toJson();
  json['meal'] = selectedMeal;
  json['serving_amount'] = servingAmount;

  docFoodLog.update(json);

  // Create document and write data to Firebase
  await docFoodLog.set(json);
}
