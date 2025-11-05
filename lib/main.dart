import 'package:flutter/material.dart';
import 'ShoppingItem.dart';
import 'ShoppingDAO.dart';
import 'ShoppingDatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
  await $FloorShoppingDatabase.databaseBuilder('shopping.db').build();
  final dao = database.shoppingDAO;

  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final ShoppingDAO dao;
  const MyApp({super.key, required this.dao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Shopping List', dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ShoppingDAO dao;
  const MyHomePage({super.key, required this.title, required this.dao});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<ShoppingItem> _shoppingList = [];
  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await widget.dao.getAllItems();
    setState(() {
      _shoppingList = items;
      if (items.isNotEmpty) {
        _nextId = items.map((i) => i.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    });
  }

  Future<void> _addItem() async {
    final name = _itemController.text.trim();
    final quantityText = _quantityController.text.trim();
    if (name.isEmpty || quantityText.isEmpty) return;

    final quantity = int.tryParse(quantityText) ?? 1;
    final newItem = ShoppingItem(_nextId++, name, quantity);
    await widget.dao.insertItem(newItem);
    setState(() {
      _shoppingList.add(newItem);
    });
    _itemController.clear();
    _quantityController.clear();
  }

  Future<void> _deleteItem(ShoppingItem item) async {
    await widget.dao.deleteItem(item);
    setState(() {
      _shoppingList.remove(item);
    });
  }

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
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  onPressed: _addItem,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Item'),
                          content: Text(
                              'Do you want to delete "${item.name}" from the list?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteItem(item);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      '${index + 1}. ${item.name} — Qty: ${item.quantity}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
