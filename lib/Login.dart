
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SignUpScreen());
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: SingleChildScrollView(
        child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/signup.png', // Make sure to add this image to your assets folder
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    SizedBox(height: 280,),
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    // Username Input
                   inputField(
                     headerType: "Username",
                   ),

                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle show password logic here
                              },
                              child: Text(
                                'Show',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            filled: true,
                            fillColor: Colors.white, // Background color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.black, // Border color
                                width: 1, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2, // Slightly thicker border when focused
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Password Input

                    SizedBox(height: 10),

                    // Have an Account? Login Row
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Forget password?',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle login tap
                          },
                          child: Text(
                            'don\'t have account',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9260F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child:
                        AutoSizeText(
                          'Login',
                          style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Progress bar (initially invisible)
                    Visibility(
                      visible: false,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),

          ),
        ],
      ),
    ),),
    );
  }

  Widget inputField({
    required String headerType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerType ,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: headerType == "" ? 0 : 8),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1, // Border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2, // Slightly thicker border when focused
              ),
            ),
          ),
        ),
      ],
    );
  }
}

























// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart'; // For making HTTP requests
// import 'validators.dart'; // You'll need to implement Validators similar to your Android code
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   bool isLoading = false;
//   final Dio _dio = Dio();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: "Username"),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             SizedBox(height: 16),
//             isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: _onSignUp,
//               child: Text("Sign Up"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/login'); // Navigate to login
//               },
//               child: Text("Already have an account? Login here"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onSignUp() async {
//     // Validate inputs
//     if (!Validators.isValidEmail(emailController.text) ||
//         !Validators.isValidUsername(usernameController.text) ||
//         !Validators.isValidPassword(passwordController.text)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please provide valid inputs")),
//       );
//       return;
//     }
//
//     // If valid, proceed with API request
//     setState(() {
//       isLoading = true;
//     });
//
//     final data = {
//       "username": usernameController.text,
//       "email": emailController.text,
//       "password": passwordController.text,
//     };
//
//     try {
//       Response response = await _dio.post(
//         'https://your-api-endpoint.com/register', // Replace with your API endpoint
//         data: data,
//         options: Options(contentType: Headers.jsonContentType),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Success - save user data to SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', false);
//         await prefs.setInt('userId', response.data['id']);
//
//         // Navigate to login page
//         Navigator.pushReplacementNamed(context, '/login');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Sign up failed")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Server error: Please try again later")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }
