import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dawra/models/user_model.dart';
import 'package:dawra/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final response = await ApiService.post('login', {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      });

      final user = User.fromJson(response['user']);
      final token = response['token'];

      // Save token and user data to shared preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('user', jsonEncode(user.toJson()));

      // Navigate to the appropriate screen based on user role
      if (user.role == 'student') {
        Navigator.pushReplacementNamed(context, '/student');
      } else if (user.role == 'teacher') {
        Navigator.pushReplacementNamed(context, '/teacher');
      } else if (user.role == 'parent') {
        Navigator.pushReplacementNamed(context, '/parent');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
