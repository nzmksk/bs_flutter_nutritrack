import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

double setBMI = 0;

class _ProfilePageState extends State<ProfilePage> {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();

  void calBMI() {
    final height = double.parse(_height.text);
    final weight = double.parse(_weight.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      final bmi = weight / (height * height);

      setState(() {
        setBMI = bmi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Stack(children: [
      SizedBox(height: 150),
      Align(
        alignment: Alignment.topCenter,
        child: FractionalTranslation(
          translation: Offset(0, 0.2),
          child: Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(children: [
          SizedBox(height: 150),
          TextFormField(
            controller: _name,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black)),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _username,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black)),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black)),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _height,
            decoration: InputDecoration(
              labelText: 'Height',
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black)),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _weight,
            decoration: InputDecoration(
              labelText: 'Weight',
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black)),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: calBMI,
            child: Text('Calculate BMI'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // set the background color of the button
              textStyle: TextStyle(
                fontSize: 20, // set the font size of the text in the button
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal:
                      30), // set the padding around the text in the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20), // set the border radius of the button
              ),
            ),
          ),
          SizedBox(height: 30),
          if (setBMI != null)
            Text(
              'Your BMI Total: ${setBMI.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 35),
            ),
        ]),
      )
    ])
    ));
  }
}
