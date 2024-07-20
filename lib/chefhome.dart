import 'package:flutter/material.dart';
import 'package:flutter_application_1/chef_orderchat.dart';
import 'package:flutter_application_1/foodlist.dart';
import 'package:flutter_application_1/info.dart';

class ChefHomeScreen extends StatefulWidget {
  const ChefHomeScreen({Key? key}) : super(key: key);

  @override
  _ChefHomeScreenState createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  final List<PreferredSizeWidget> _appBars = [
    AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: TopWidgetHome(),
      backgroundColor: Color.fromRGBO(238, 221, 198, 1),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: TopWidgetChat(),
      backgroundColor: Color.fromRGBO(238, 221, 198, 1),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: TopWidgetOrders(),
      backgroundColor: Color.fromRGBO(238, 221, 198, 1),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: TopWidgetProfile(),
      backgroundColor: Color.fromRGBO(238, 221, 198, 1),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBars[_selectedIndex],
        body: _widgetOptions[_selectedIndex],
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
      ),
    );
  }
}

class TopWidgetHome extends StatefulWidget {
  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class TopWidgetChat extends StatefulWidget {
  @override
  _TopWidgetChatState createState() => _TopWidgetChatState();
}

class _TopWidgetChatState extends State<TopWidgetChat> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.fromLTRB(30, 60, 30, 0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 3),
            child: const Text(
              'Messages',
              style: TextStyle(
                color: Color.fromRGBO(50, 52, 62, 1),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopWidgetOrders extends StatefulWidget {
  @override
  _TopWidgetOrdersState createState() => _TopWidgetOrdersState();
}

class _TopWidgetOrdersState extends State<TopWidgetOrders> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.fromLTRB(30, 60, 30, 0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 3),
            child: const Text(
              'My Orders',
              style: TextStyle(
                color: Color.fromRGBO(50, 52, 62, 1),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopWidgetProfile extends StatefulWidget {
  @override
  _TopWidgetProfileState createState() => _TopWidgetProfileState();
}

class _TopWidgetProfileState extends State<TopWidgetProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.fromLTRB(30, 60, 30, 0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 3),
            child: const Text(
              'Profile',
              style: TextStyle(
                color: Color.fromRGBO(50, 52, 62, 1),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TopWidgetState extends State<TopWidgetHome> {
  Future<String> fetchAddress() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating a network call
    return "Malini Apartments";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 56,
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 7,
            right: screenWidth * 0.05,
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Home/Image2186.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            top: 13,
            left: screenWidth * 0.2,
            child: Text(
              'LOCATION',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(73, 45, 28, 1),
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: screenWidth * 0.2,
            child: FutureBuilder<String>(
              future: fetchAddress(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...', textAlign: TextAlign.left);
                } else if (snapshot.hasError) {
                  return Text('Error', textAlign: TextAlign.left);
                } else {
                  return Text(
                    snapshot.data ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(103, 103, 103, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            right: screenWidth * 0.2,
            child: Container(
              width: 48,
              height: 53,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 8,
                    left: 0,
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodListScreen()),
                        )
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/Home/Image2185.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Home/Image2184.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
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
                _buildStatCard('Running Orders', '20', Colors.blue),
                _buildStatCard('Order Request', '05', Colors.grey),
              ],
            ),
            SizedBox(height: 16),
            _buildRevenueCard(),
            SizedBox(height: 16),
            _buildReviewCard(),
            SizedBox(height: 16),
            _buildMostOrderedItems(),
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

  Widget _buildRevenueCard() {
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
                '\$2,241',
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

  Widget _buildReviewCard() {
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
      child: Row(
        children: [
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 36),
                  SizedBox(width: 8),
                  Text(
                    '4.9',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'Total 20 Reviews',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              'See All Reviews',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> mostOrderedItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  Widget _buildMostOrderedItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most ordered items from your kitchen',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mostOrderedItems.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: EdgeInsets.only(right: 16),
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    mostOrderedItems[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FoodOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Order Page')),
      body: Center(child: Text('Food Order Page')),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabBar(
        indicatorColor: Color.fromRGBO(74, 46, 29, 1),
        labelColor: Color.fromRGBO(74, 46, 29, 1),
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(text: "Messages (3)"),
          Tab(text: "Notifications"),
        ],
      ),
      Expanded(
        child: TabBarView(
          children: [
            ChatList(),
            NotificationList(),
          ],
        ),
      ),
    ]);
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabBar(
        indicatorColor: Color.fromRGBO(74, 46, 29, 1),
        labelColor: Color.fromRGBO(74, 46, 29, 1),
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Tab(text: 'Ongoing'),
          Tab(text: 'History'),
        ],
      ),
      Expanded(
        child: TabBarView(
          children: [
            ChefOngoingOrders(),
            ChefHistoryOrders(),
          ],
        ),
      ),
    ]);
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/Profile/Chechi.png'), // Example profile image
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Chechi's Chaikada",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Mallu aunty',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    context,
                    title: 'Personal Info',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonalInfoPage()),
                      );
                    },
                    iconColor: Colors.redAccent,
                  ),
                  _buildSection(
                    context,
                    title: 'Settings',
                    icon: Icons.settings,
                    onTap: () {},
                    iconColor: Colors.deepPurple,
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    context,
                    title: 'Withdrawal History',
                    icon: Icons.history,
                    onTap: () {},
                    iconColor: Colors.orange,
                    trailing: '',
                  ),
                  _buildSection(
                    context,
                    title: 'Number of Orders',
                    icon: Icons.shopping_bag,
                    onTap: () {},
                    iconColor: Colors.blue,
                    trailing: '29K',
                  ),
                  _buildSection(
                    context,
                    title: 'User reviews',
                    icon: Icons.reviews,
                    onTap: () {},
                    iconColor: Colors.green,
                  ),
                  _buildSection(
                    context,
                    title: 'Available balance',
                    icon: Icons.account_balance_wallet,
                    onTap: () {},
                    iconColor: Colors.teal,
                    trailing: '\$500',
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    context,
                    title: 'Log Out',
                    icon: Icons.logout,
                    onTap: () {},
                    iconColor: Colors.red,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color iconColor,
    String trailing = '',
  }) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: ListTile(
            leading: Icon(icon, color: iconColor),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: trailing.isNotEmpty
                ? Text(
                    trailing,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
      ),
      body: Center(
        child: Text('Personal Info Page'),
      ),
    );
  }
}
