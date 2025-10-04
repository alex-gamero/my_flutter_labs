import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstController;
  late TextEditingController _lastController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    // Load current values from repository into controllers
    _firstController = TextEditingController(text: DataRepository.instance.firstName);
    _lastController = TextEditingController(text: DataRepository.instance.lastName);
    _phoneController = TextEditingController(text: DataRepository.instance.phone);
    _emailController = TextEditingController(text: DataRepository.instance.email);

    // Save to repository whenever text changes
    _firstController.addListener(_onChanged);
    _lastController.addListener(_onChanged);
    _phoneController.addListener(_onChanged);
    _emailController.addListener(_onChanged);
  }

  void _onChanged() {
    DataRepository.instance.firstName = _firstController.text;
    DataRepository.instance.lastName = _lastController.text;
    DataRepository.instance.phone = _phoneController.text;
    DataRepository.instance.email = _emailController.text;
    // persist immediately
    DataRepository.instance.saveData();
  }

  @override
  void dispose() {
    _firstController.removeListener(_onChanged);
    _lastController.removeListener(_onChanged);
    _phoneController.removeListener(_onChanged);
    _emailController.removeListener(_onChanged);

    _firstController.dispose();
    _lastController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(Uri uri, String schemeName) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // show alert if URL type isn't supported
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Not supported'),
          content: Text('This device cannot handle $schemeName URLs'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
          ],
        ),
      );
    }
  }

  void _callPhone() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No phone number'),
          content: const Text('Please enter a phone number first.'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);
    await _launchUrl(uri, 'tel');
    //await launchUrl(uri);
  }

  void _sendSms() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No phone number'),
          content: const Text('Please enter a phone number first.'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
      return;
    }

    final uri = Uri(scheme: 'sms', path: phone);
    await _launchUrl(uri, 'sms');
    //await launchUrl(uri);
  }

  void _sendMail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No email address'),
          content: const Text('Please enter an email address first.'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
      return;
    }

    final uri = Uri(scheme: 'mailto', path: email);
    await _launchUrl(uri, 'mailto');
    //await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    // Login name from previous page is passed as argument
    final loginName = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back ${loginName.isNotEmpty ? loginName : DataRepository.instance.firstName}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              // First name
              TextField(
                controller: _firstController,
                decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),

              // Last name
              TextField(
                controller: _lastController,
                decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),

              // Phone with two buttons (Telephone, SMS)
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _callPhone, child: const Icon(Icons.phone)),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _sendSms, child: const Icon(Icons.sms)),
                ],
              ),

              const SizedBox(height: 12),

              // Email with mail button
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email address', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _sendMail, child: const Icon(Icons.mail)),
                ],
              ),

              const SizedBox(height: 20),

              // quick debug button to clear stored profile (optional)
              FilledButton(
                onPressed: () async {
                  await DataRepository.instance.clearAll();
                  setState(() {
                    _firstController.text = '';
                    _lastController.text = '';
                    _phoneController.text = '';
                    _emailController.text = '';
                  });
                },
                child: const Text('Clear saved profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
