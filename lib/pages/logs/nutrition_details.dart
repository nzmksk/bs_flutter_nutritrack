import 'package:bs_flutter_nutritrack/models/models.dart';
import 'package:flutter/material.dart';

class NutritionDetailsPage extends StatefulWidget {
  final BrandedFoodNutritionModel foodItem;

  const NutritionDetailsPage({super.key, required this.foodItem});

  @override
  State<NutritionDetailsPage> createState() => _NutritionDetailsPageState();
}

class _NutritionDetailsPageState extends State<NutritionDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
                        '${widget.foodItem.totalCalories} kcal',
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
                        '${widget.foodItem.totalFat} g',
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
                        '${widget.foodItem.saturatedFat} g',
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
                        '${widget.foodItem.cholesterol} mg',
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
                        '${widget.foodItem.sodium} mg',
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
                        '${widget.foodItem.totalCarbohydrates} g',
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
                        '${widget.foodItem.dietaryFiber} g',
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
                        '${widget.foodItem.sugars} g',
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
                        '${widget.foodItem.protein} g',
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
                        '${widget.foodItem.potassium} mg',
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
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
