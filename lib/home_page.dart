// home_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? 'No token found';
  }

  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'No username found';
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('username');
    Navigator.pushReplacementNamed(context, '/login'); // Navigate back to login page
  }

   Future<void> _todos(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushReplacementNamed(context, '/todos'); // Navigate todos page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: _getUsername(),
              builder: (context, snapshot) {
                return Text('Username: ${snapshot.data}');
              },
            ),
            FutureBuilder<String>(
              future: _getToken(),
              builder: (context, snapshot) {
                return Text('Token: ${snapshot.data}');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 10,),
             ElevatedButton(
              onPressed: () => _todos(context),
              child: const Text('Todo page'),
            ),
          ],
        ),
      ),
    );
  }
}
