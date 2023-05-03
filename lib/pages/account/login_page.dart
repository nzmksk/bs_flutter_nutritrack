import 'package:bs_flutter_nutritrack/pages/account/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool _passwordVisible = false;
  // bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Stack(
        children: [
          Opacity(
            opacity: 0.65, // Set opacity value between 0.0 to 1.0
            child: Image.network(
              "https://media.istockphoto.com/id/1457433817/photo/group-of-healthy-food-for-flexitarian-diet.jpg?b=1&s=170667a&w=0&k=20&c=RKgGJW8aIINIPpisynZ2x6UWFiMZ0afmEN32gmbYvVI=",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7), // set your desired background color here
                  borderRadius: BorderRadius.circular(20.0),
                
                ),  
                   child: Padding(
              padding: const EdgeInsets.all(.0),
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 150.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          validator: (input) {},
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 25, color: Colors.black)),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          validator: (input) {},
                          // obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 25, color: Colors.black)),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: 50.0,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                        ),
                         SizedBox(height: 30),
                        GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                       
                        child: Text(
                          "Already don't have an account? Sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ),
          )
        ],
      )
    );
  }
}


// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
  
//   @override
//   State<LoginPage> createState()=> _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context){
    
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors:[
//             Colors.blue,
//             Colors.red,
//           ], 
//         )),
//         child:Scaffold(
//           backgroundColor:Colors.transparent,
//           body:_page(),
//         ),
//     );
 
//   }

// }