import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/services/database.dart';

class ChefHomeScreen extends StatefulWidget {
  const ChefHomeScreen({Key? key}) : super(key: key);

  @override
  _ChefHomeScreenState createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen> {
  final KitchenService _kitchenService = KitchenService();
  late Future<Map<String, dynamic>?> _kitchenData; // Allow null

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(kitchenData: {}), // Initialize with empty data
    Center(child: Text('Chat Screen')), // Placeholder for Chat Screen
    Center(child: Text('Orders Screen')), // Placeholder for Orders Screen
    Center(child: Text('Profile Screen')), // Placeholder for Profile Screen
  ];

  final List<AppBar> _appBars = <AppBar>[
    AppBar(
      title: Text('Home'),
      backgroundColor: Color.fromRGBO(60, 38, 12, 1),
    ),
    AppBar(
      title: Text('Chat'),
      backgroundColor: Color.fromRGBO(60, 38, 12, 1),
    ),
    AppBar(
      title: Text('Orders'),
      backgroundColor: Color.fromRGBO(60, 38, 12, 1),
    ),
    AppBar(
      title: Text('Profile'),
      backgroundColor: Color.fromRGBO(60, 38, 12, 1),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _kitchenData = _kitchenService
        .fetchKitchenData('your_kitchen_id'); // Replace with actual kitchen ID
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: _appBars[_selectedIndex].preferredSize,
          child: _appBars[_selectedIndex],
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
          future: _kitchenData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available'));
            } else {
              final kitchenData = snapshot.data!;
              _widgetOptions[0] = HomePage(kitchenData: kitchenData);
              return _widgetOptions[_selectedIndex];
            }
          },
        ),
        backgroundColor: const Color.fromRGBO(238, 221, 198, 1),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Color.fromRGBO(60, 38, 12, 1),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromRGBO(60, 38, 12, 1),
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromRGBO(60, 38, 12, 1),
              icon: Icon(Icons.receipt),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromRGBO(60, 38, 12, 1),
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new product logic
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.amber[800],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, dynamic> kitchenData;

  HomePage({required this.kitchenData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard(
                    'Running Orders',
                    kitchenData['ongoing_orders']?.length.toString() ?? '0',
                    Colors.blue),
                _buildStatCard(
                    'Order Request',
                    ((kitchenData['order_history']?.length ?? 0) -
                            (kitchenData['ongoing_orders']?.length ?? 0))
                        .toString(),
                    Colors.grey),
              ],
            ),
            SizedBox(height: 16),
            _buildRevenueCard(kitchenData),
            SizedBox(height: 16),
            _buildReviewCard(kitchenData),
            SizedBox(height: 16),
            _buildMostOrderedItems(kitchenData),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 6),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCard(Map<String, dynamic> data) {
    final revenue = data['order_history']?.fold<double>(0, (sum, order) {
          final price = double.tryParse(order['price'].toString()) ?? 0.0;
          return sum + price;
        }) ??
        0.0;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 6),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Revenue',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${revenue.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
              DropdownButton<String>(
                items:
                    <String>['Daily', 'Weekly', 'Monthly'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
                underline: Container(),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 200,
            child: Placeholder(), // Replace with your graph widget
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> data) {
    final rating = (data['rating'] ?? 0.0).toDouble();
    final reviews =
        data['order_history']?.length ?? 0; // Example for review count

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 6),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 36),
              SizedBox(width: 8),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
              Text(
                '$reviews Reviews',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMostOrderedItems(Map<String, dynamic> data) {
    final items = data['most_ordered_items'] as List<dynamic>? ?? [];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 6),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Most Ordered Items',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ...items.map((item) => ListTile(
                title: Text(item['name']),
                subtitle: Text('Ordered ${item['order_count']} times'),
              )),
        ],
      ),
    );
  }
}
