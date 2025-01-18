import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:dawra/screens/auth/login_screen.dart';
import 'package:dawra/screens/student/student_home.dart';
import 'package:dawra/screens/teacher/teacher_home.dart';
import 'package:dawra/screens/parent/parent_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student-Teacher-Parent App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data as SharedPreferences;
            final token = prefs.getString('token');
            final userJson = prefs.getString('user');

            if (token != null && userJson != null) {
              final user = User.fromJson(jsonDecode(userJson));
              if (user.role == 'student') {
                return StudentHomeScreen();
              } else if (user.role == 'teacher') {
                return TeacherHomeScreen();
              } else if (user.role == 'parent') {
                return ParentHomeScreen();
              }
            }
          }
          return LoginScreen();
        },
      ),
      routes: {
        '/student': (context) => StudentHomeScreen(),
        '/teacher': (context) => TeacherHomeScreen(),
        '/parent': (context) => ParentHomeScreen(),
      },
    );
  }
}
