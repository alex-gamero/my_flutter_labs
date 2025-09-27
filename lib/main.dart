import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week4 Lab',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fileToShow = "images/question-mark.png";
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    // Load saved username/password if available
    Future.delayed(Duration.zero, () async {
      String? savedUser = await prefs.getString("username");
      String? savedPass = await prefs.getString("password");

      if (savedUser != null && savedUser.isNotEmpty &&
          savedPass != null && savedPass.isNotEmpty) {
        setState(() {
          _usernameController.text = savedUser;
          _passwordController.text = savedPass;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Previous login loaded")),
        );
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Save username and password
  Future<void> saveCredentials() async {
    await prefs.setString("username", _usernameController.text);
    await prefs.setString("password", _passwordController.text);
  }

  // Clear saved data
  Future<void> clearCredentials() async {
    await prefs.clear();
  }

  void _onLoginPressed() {
    // Show AlertDialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save Credentials"),
        content: const Text("Do you want to save your username and password?"),
        actions: [
          TextButton(
            onPressed: () async {
              await saveCredentials();
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () async {
              await clearCredentials();
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Login",
                  labelText: "Login",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  labelText: "Password",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onLoginPressed,
              child: const Text("Login"),
            ),
            const SizedBox(height: 20),
            Semantics(
              child: Image.asset(fileToShow, height: 100, width: 100),
            ),
          ],
        ),
      ),
    );
  }
  }
