import 'package:flutter/material.dart';
import 'AddNewItemScreen.dart';

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<Map<String, dynamic>> foodList = [
    {
      'name': 'Chicken Thai Biryani',
      'price': 60,
      'image':
          'assets/images/foodlist/chickbir.png', // Replace with actual image path
      'rating': 4.9,
      'reviews': 10,
    },
    {
      'name': 'Idli & vada',
      'price': 30,
      'image':
          'assets/images/foodlist/idly.png', // Replace with actual image path
      'rating': 4.9,
      'reviews': 10,
    },
    {
      'name': 'Puliyogare',
      'price': 25,
      'image':
          'assets/images/foodlist/p1.png', // Replace with actual image path
      'rating': 4.9,
      'reviews': 10,
    },
  ];

  void _addNewItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewItemScreen()),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      foodList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Food List'),
        backgroundColor: Color(0xFFEEDDC6),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Container(
        color: Color(0xFFEEDDC6), // Full page background color
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final item = foodList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              child: ListTile(
                leading: Image.asset(
                  item['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  item['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text('\$${item['price']}'),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text('${item['rating']} (${item['reviews']} reviews)'),
                      ],
                    ),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'delete') {
                      _deleteItem(index);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewItemScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 231, 185, 130),
      ),
    );
  }
}
