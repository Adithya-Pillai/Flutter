import 'package:flutter/material.dart';
import 'package:flutter_application_1/address_page.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/widgets/loading.dart';

class MyAddressPage extends StatefulWidget {
  final String id; // User ID

  MyAddressPage({required this.id});

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  final DatabaseService _dbService = DatabaseService();

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
        child: StreamBuilder<Map<String, dynamic>?>(
          stream: _dbService.fetchUserProfile(widget.id).asStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Loading());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var userData = snapshot.data ?? {};
              List<Map<String, dynamic>> addresses =
                  List<Map<String, dynamic>>.from(
                userData['addresses'] ?? [],
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        var address = addresses[index];
                        return _buildAddressCard(
                          icon: address['type'] == 'Home'
                              ? Icons.home
                              : Icons.work,
                          iconColor: address['type'] == 'Home'
                              ? Colors.blue
                              : Colors.purple,
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
                        onPressed: _addNewAddress,
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
              );
            }
          },
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
              Container(
                width: 190,
                child: Text.rich(
                  TextSpan(
                    text: subtitle ?? '',
                    style: TextStyle(
                      color: Color.fromRGBO(103, 103, 103, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black54),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  void _addNewAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAddressPage()),
    );
  }

  void _deleteAddress(int index) async {
    try {
      var userData = await _dbService.fetchUserProfile(widget.id);
      if (userData != null) {
        var addresses =
            List<Map<String, dynamic>>.from(userData['addresses'] ?? []);

        if (addresses.length > index) {
          addresses.removeAt(index);

          await _dbService.updateUserData(widget.id, addresses: addresses);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Address deleted successfully'),
            duration: Duration(seconds: 2),
          ));

          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Address index out of bounds'),
            duration: Duration(seconds: 2),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User data not found'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting address: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}

class KitchenAddressPage extends StatefulWidget {
  final String kitchenId;

  KitchenAddressPage({required this.kitchenId});

  @override
  _KitchenAddressPageState createState() => _KitchenAddressPageState();
}

class _KitchenAddressPageState extends State<KitchenAddressPage> {
  final DatabaseService _dbService = DatabaseService();

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
        title: Text(
          'Address',
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
        child: StreamBuilder<Map<String, dynamic>?>(
          stream: _dbService.fetchKitchenProfile(widget.kitchenId).asStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Loading());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var kitchenData = snapshot.data ?? {};
              var address = kitchenData['address'] ?? '';

              return Column(
                children: [
                  _buildAddressCard(
                    icon: Icons.location_on,
                    iconColor: Colors.blue,
                    title: 'Kitchen Address',
                    subtitle: address,
                    onDelete: () => _deleteAddress(),
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
                        onPressed: _addNewAddress,
                        child: Text(
                          'UPDATE ADDRESS',
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
              );
            }
          },
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
              Container(
                width: 190,
                child: Text.rich(
                  TextSpan(
                    text: subtitle ?? '',
                    style: TextStyle(
                      color: Color.fromRGBO(103, 103, 103, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black54),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  void _addNewAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAddressPage()),
    );
  }

  void _deleteAddress() async {
    try {
      var kitchenData = await _dbService.fetchKitchenProfile(widget.kitchenId);
      if (kitchenData != null) {
        var address = kitchenData['address'] ?? '';

        // Update kitchen data in Firestore
        await _dbService.updateKitchenData(widget.kitchenId, address: '');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Address deleted successfully'),
          duration: Duration(seconds: 2),
        ));

        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Kitchen data not found'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Error deleting address: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting address: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
