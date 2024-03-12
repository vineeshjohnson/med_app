import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Departments extends StatefulWidget {
  const Departments({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DepartmentsState createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
  List<ContainerItem> containerList = [];
  final TextEditingController _category = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<String>('categories');
    await _loadData();
  }

  Future<void> _loadData() async {
    final box = await Hive.openBox<String>('categories');
    List<String> categories = box.values.toList();

    setState(() {
      containerList = categories
          .map((category) => ContainerItem(
                text: category,
                onDelete: _deleteCategory,
              ))
          .toList();
    });
  }

  void _showAddContainerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Add Department'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _category,
                decoration: const InputDecoration(labelText: 'Department'),
                onChanged: (text) {
                  // Handle text input
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String text = _category.text;
                  await _saveCategory(text);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text('Add Department'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveCategory(String category) async {
    final box = await Hive.openBox<String>('categories');
    await box.add(category);
    await _loadData();
  }

  Future<void> _deleteCategory(String category) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Department'),
          content: Text('Are you sure you want to delete $category?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final box = await Hive.openBox<String>('categories');
                int index = box.values.toList().indexOf(category);

                await box.deleteAt(index);
                await _loadData();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: const Text('Departments'),
      ),
      body: ListView.builder(
        itemCount: containerList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: containerList[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContainerDialog(context),
        tooltip: 'Add Department',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContainerItem extends StatelessWidget {
  final String text;
  final Function(String) onDelete;

  const ContainerItem({Key? key, required this.text, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.cyan.shade200,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  onDelete(text);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
