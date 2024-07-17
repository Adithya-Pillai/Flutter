import 'package:flutter/material.dart';
import 'package:flutter_application_1/addressedit.dart';

class MyAddressPage extends StatefulWidget {
  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  List<Map<String, String>> addresses = [
    {
      'type': 'HOME',
      'address': 'India',
      'icon': 'home',
    },
    {
      'type': 'WORK',
      'address': 'MG ROAD',
      'icon': 'work',
    },
  ];

  void _addNewAddress() {
    setState(() {
      addresses.add({
        'type': 'NEW ADDRESS',
        'address': 'New Address Details',
        'icon': 'location_on',
      });
    });
  }

  void _deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 221, 198, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 221, 198, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Addresses',
          style: TextStyle(
            color: Color.fromRGBO(50, 52, 62, 1),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  var address = addresses[index];
                  return _buildAddressCard(
                    icon: address['icon'] == 'home' ? Icons.home : Icons.work,
                    iconColor:
                        address['icon'] == 'home' ? Colors.blue : Colors.purple,
                    title: address['type']!,
                    subtitle: address['address']!,
                    onDelete: () => _deleteAddress(index),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD19A73),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddAddressPage()),
                    );
                  },
                  child: Text(
                    'ADD NEW ADDRESS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black54),
            onPressed: () {
              // Handle edit button press
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black54),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
