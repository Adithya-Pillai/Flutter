import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantViewScreen extends StatefulWidget {
  final String kitchenId;

  const RestaurantViewScreen({Key? key, required this.kitchenId})
      : super(key: key);

  @override
  _RestaurantViewScreenState createState() => _RestaurantViewScreenState();
}

class _RestaurantViewScreenState extends State<RestaurantViewScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _kitchenFuture;
  List<Map<String, dynamic>> items = [];
  String selectedCategory = 'All'; // Default category to show all items
  Map<String, int> counters = {};

  @override
  void initState() {
    super.initState();
    _kitchenFuture = _fetchKitchenData();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchKitchenData() async {
    try {
      return await FirebaseFirestore.instance
          .collection('kitchens')
          .doc(widget.kitchenId)
          .get();
    } catch (e) {
      print('Error fetching kitchen data: $e');
      rethrow;
    }
  }

  final Color backgroundColor = Color(0xFFF5E6C9);

  void incrementCounter(String dish, int stockQuantity) {
    setState(() {
      final currentCount = counters[dish] ?? 0;
      if (currentCount < stockQuantity) {
        counters[dish] = currentCount + 1;
      } else {
        // Optional: Show a message if stock is insufficient
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cannot increment beyond stock quantity'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void decrementCounter(String dish) {
    setState(() {
      final currentCount = counters[dish] ?? 0;
      if (currentCount > 0) {
        counters[dish] = currentCount - 1;
      }
    });
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Restaurant View',
          style: TextStyle(
            color: Color.fromRGBO(50, 52, 62, 1),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _kitchenFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          }

          final kitchenData = snapshot.data!.data()!;
          items = List<Map<String, dynamic>>.from(kitchenData['items'] ?? []);
          counters = Map<String, int>.from(items.fold(
              {},
              (prev, curr) => {
                    ...prev,
                    curr['name']: counters[curr['name']] ?? 0,
                  }));

          // Extract unique category IDs
          Set<String> uniqueCategories =
              items.map((item) => item['category_id'].toString()).toSet();

          return Container(
            color: backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            kitchenData['kitchenimage'] ??
                                'assets/images/placeholder_image.jpg',
                            height: MediaQuery.of(context).size.height *
                                0.3, // Responsive height
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          kitchenData['name'] ?? 'Restaurant Name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          kitchenData['bio'] ?? 'Description not available',
                          style: TextStyle(fontSize: 14, color: Colors.brown),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.red),
                            SizedBox(width: 4),
                            Text(
                              kitchenData['rating'] != null
                                  ? kitchenData['rating'].toString()
                                  : 'N/A',
                              style: TextStyle(color: Colors.brown),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.delivery_dining, color: Colors.red),
                            SizedBox(width: 4),
                            Text('Free', style: TextStyle(color: Colors.brown)),
                            SizedBox(width: 16),
                            Icon(Icons.timer, color: Colors.red),
                            SizedBox(width: 4),
                            Text('20 min',
                                style: TextStyle(color: Colors.brown)),
                          ],
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            GestureDetector(
                              onTap: () => selectCategory('All'),
                              child: Chip(
                                label: Text('All'),
                                backgroundColor: selectedCategory == 'All'
                                    ? Colors.red
                                    : Colors.grey[200],
                                labelStyle: TextStyle(
                                  color: selectedCategory == 'All'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                            ...uniqueCategories.map((category) {
                              return GestureDetector(
                                onTap: () => selectCategory(category),
                                child: Chip(
                                  label: Text(category),
                                  backgroundColor: selectedCategory == category
                                      ? Colors.red
                                      : Colors.grey[200],
                                  labelStyle: TextStyle(
                                    color: selectedCategory == category
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          selectedCategory,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: items.map((item) {
                        if (selectedCategory == 'All' ||
                            item['category_id'].toString() ==
                                selectedCategory) {
                          final stockQuantity = item['quantity'] ?? 0;
                          final itemName = item['name'] ?? 'Item Name';
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  item['image_item'] ??
                                      'assets/images/placeholder_image.jpg',
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                itemName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['description'] ??
                                        'Description not available',
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                  Text(
                                    'Rs. ${item['price'] ?? '0'}/-',
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, color: Colors.red),
                                    onPressed: () => decrementCounter(itemName),
                                  ),
                                  Text(
                                    counters[itemName]?.toString() ?? '0',
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.green),
                                    onPressed: () => incrementCounter(
                                      itemName,
                                      stockQuantity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
