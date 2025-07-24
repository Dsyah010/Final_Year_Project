import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fyp/setting.dart';
import 'package:fyp/highlight.dart';
import 'package:fyp/profile.dart';
import 'package:fyp/sign_in.dart'; // Assuming this is the sign-in page
import 'package:fyp/create_account.dart';
import 'package:fyp/spiker.dart';
import 'package:fyp/tekong.dart';
import 'package:fyp/training.dart';
import 'package:fyp/technique.dart';
import 'package:sqflite/sqflite.dart'; // Or any database package you are using



import 'db_helper.dart';
import 'home.dart'; // Assuming this is the account creation page

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final directory = await getApplicationDocumentsDirectory();
    print('Application documents directory: ${directory.path}');
  } catch (e) {
    print('Error getting application documents directory: $e');
  }

  runApp(SepakTakrawApp());
}

class SepakTakrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Container
          Container(
            width: MediaQuery.of(context).size.width,
            height: 128,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join Sepak Takraw',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Create your account to start playing",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Color(0xFFE0E0E0),
                      letterSpacing: 0.0,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Create Account page
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateAccountPage(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,  // Text color
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 120),  // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),  // Rounded corners
                      ),
                      elevation: 5,  // Button shadow
                    ),
                    child: Text('Create Account'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Sign In page
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignIn(), // Ensure SignIn is implemented
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,  // Text color
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 145),  // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),  // Rounded corners
                      ),
                      elevation: 5,  // Button shadow
                    ),
                    child: Text('Sign In'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}