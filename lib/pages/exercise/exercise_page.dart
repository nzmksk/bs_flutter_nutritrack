import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late TextEditingController _exerciseController = TextEditingController();
  String _exerciseQuery = '';
  late Map<String, dynamic> _exerciseDetails = {};
  bool _isLoading = false;

  //API part
  String appId = dotenv.env['NUTRITIONIX_APP_ID']!;
  String apiKey = dotenv.env['NUTRITIONIX_API_KEY']!;

  Future<void> exerciseInfo(String _exerciseQuery) async {
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
      body: json.encode({'query': _exerciseQuery}),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['branded'];
      setState(() {
        final responseData = json.decode(response.body);
        _exerciseDetails = responseData;
      });
    } else {
      throw Exception('No data found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Padding(
          padding: EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              'Enter the type of exercise',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(
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
                  hintText: 'eg:Run / run for 2 minutes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  _exerciseQuery = value;
                },
              ),
            ),
            SizedBox(
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
                  minimumSize: Size(50, 50), // button minimum size
                ),
                onPressed: _exerciseQuery != null
                    ? () => exerciseInfo(_exerciseQuery)
                    : null,
                child: Text('Get exercise'),
              ),
            ),
            SizedBox(height: 16.0),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (_exerciseQuery != null && _exerciseQuery.isNotEmpty)
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
                        Center(
                          child: Text(
                            'Exercise Details',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Exercise: ${_exerciseDetails['exercises'][0]['name']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Duration: ${_exerciseDetails['exercises'][0]['duration_min']} minutes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Calories Burned: ${_exerciseDetails['exercises'][0]['nf_calories']} kcal',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Image.network(
                            _exerciseDetails['exercises'][0]['photo']['thumb'],
                            height: 100)
                      ],
                    ),
                  ),
                ),
              )
          ])),
    )));
  }
}
