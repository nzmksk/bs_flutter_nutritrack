import 'dart:convert';

import 'package:bs_flutter_nutritrack/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late final TextEditingController _exerciseController =
      TextEditingController();
  String _exerciseQuery = '';
  late List<ExerciseInfoModel> _exerciseInfoModel = [];
  // late Map<String, dynamic> _exerciseDetails = {};
  bool _isLoading = false;

  //API part
  String appId = dotenv.env['NUTRITIONIX_APP_ID']!;
  String apiKey = dotenv.env['NUTRITIONIX_API_KEY']!;

  Future<void> _fetchExerciseInfo(String query) async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await http.post(
      Uri.parse('https://trackapi.nutritionix.com/v2/natural/exercise'),
      headers: {
        'x-app-id': appId,
        'x-app-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'query': query}),
    );

    setState(() {
      _isLoading = false;
    });

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body)['exercises'];
        setState(() {
          _exerciseInfoModel = (data as List)
              .map((exercise) => ExerciseInfoModel.fromJson(exercise))
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

  @override
  void dispose() {
    _exerciseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter the type of exercise',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                    controller: _exerciseController,
                    decoration: InputDecoration(
                      hintText: 'eg: Run for 2 minutes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _exerciseQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // background color
                      foregroundColor: Colors.white, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // button border radius
                      ),
                      minimumSize: const Size(50, 50), // button minimum size
                    ),
                    onPressed: _exerciseQuery.isNotEmpty
                        ? () => _fetchExerciseInfo(_exerciseQuery)
                        : null,
                    child: const Text('Get exercise'),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (_exerciseInfoModel.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.indigo,
                            width: 3,
                          ),
                        ),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Center(
                                  child: Text(
                                    'Exercise Details',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Exercise: ${_exerciseInfoModel.first.exerciseName!.toUpperCase()}',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Duration: ${_exerciseInfoModel.first.durationMin} minutes',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Calories Burned: ${_exerciseInfoModel.first.caloriesBurnt} kcal',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.indigo, // background color
                                    foregroundColor: Colors.white, // text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // button border radius
                                    ),
                                    minimumSize: const Size(
                                        50, 50), // button minimum size
                                  ),
                                  onPressed: null,
                                  child: const Text('Add to Calorie Burnt'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
