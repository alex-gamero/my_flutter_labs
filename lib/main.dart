import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Shopping List'),
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
  // Text controllers for input fields
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // List of items (each item is a map with name and quantity)
  final List<Map<String, String>> _shoppingList = [];

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListPage(),
    );
  }

  // Function that builds the page content
  Widget ListPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Row with input fields and Add button
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _itemController,
                  decoration: const InputDecoration(
                    labelText: 'Item name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final item = _itemController.text.trim();
                  final quantity = _quantityController.text.trim();

                  if (item.isNotEmpty && quantity.isNotEmpty) {
                    setState(() {
                      _shoppingList.add({
                        'item': item,
                        'quantity': quantity,
                      });
                      _itemController.clear();
                      _quantityController.clear();
                    });
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // List of items or empty message
          Expanded(
            child: _shoppingList.isEmpty
                ? const Center(
              child: Text(
                'There are no items in the list',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _shoppingList.length,
              itemBuilder: (context, index) {
                final item = _shoppingList[index];
                return GestureDetector(
                  onLongPress: () {
                    // Ask user if they want to delete item
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Item'),
                        content: Text(
                            'Do you want to delete "${item['item']}" from the list?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _shoppingList.removeAt(index);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  // Text style for each item
                    child: Text(
                      '${index + 1}. ${item['item']} — Qty: ${item['quantity']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
