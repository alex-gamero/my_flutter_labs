import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

import 'data_repository.dart';
import 'profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load repository so ProfilePage can read cached values immediately
  await DataRepository.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week5 Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Login Page'),
        '/profile': (context) => const ProfilePage(),
      },
      initialRoute: '/',
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

  // Simple login validator: password must be exactly 'password'
  void _onLoginPressed() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Missing fields"),
          content: const Text("Please enter both login and password."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    if (password == 'password') {
      // Show snackbar with the login name
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome Back $username')),
      );

      // Navigate to profile and pass the login name as an argument
      Navigator.pushNamed(context, '/profile', arguments: username);
    } else {
      // Invalid credentials
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid credentials"),
          content: const Text("The password is incorrect. Use 'password' for the lab."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
          ],
        ),
      );
    }
  }

  // Save username and password (kept from Week4 example)
  Future<void> saveCredentials() async {
    await prefs.setString("username", _usernameController.text);
    await prefs.setString("password", _passwordController.text);
  }

  Future<void> clearCredentials() async {
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // small helper to save credentials if user wants to
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
        },
        tooltip: 'Save credentials',
        child: const Icon(Icons.save),
      ),
    );
  }
}
