import 'package:flutter/material.dart';
import 'package:flutter_application_1/congratulations.dart';
import 'package:flutter_application_1/payment2.dart';

class Androidlarge21Widget extends StatefulWidget {
  const Androidlarge21Widget({Key? key}) : super(key: key);

  @override
  _Androidlarge21WidgetState createState() => _Androidlarge21WidgetState();
}

class _Androidlarge21WidgetState extends State<Androidlarge21Widget> {
  bool _showUPIInput = false;

  void _toggleUPIInput() {
    setState(() {
      _showUPIInput = !_showUPIInput;
    });
  }

  void _navigateToCongratulationsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CongratulationsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 221, 198, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Color.fromRGBO(50, 52, 62, 1),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFEEE0C6),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Text(
              'You are almost there...Choose your payment method',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            paymentMethodItem(
                context, 'Visa', 'assets/images/payment1/visa.png'),
            GestureDetector(
              onTap: _toggleUPIInput,
              child: paymentMethodItem(
                  context, 'UPI Payment', 'assets/images/payment1/upi.png'),
            ),
            if (_showUPIInput) ...[
              SizedBox(height: screenHeight * 0.02),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter UPI ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
            SizedBox(height: screenHeight * 0.02),
            GestureDetector(
              onTap: _navigateToCongratulationsPage,
              child: paymentMethodItem(context, 'Cash on Delivery',
                  'assets/images/payment1/cash.png'),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: screenWidth * 0.045,
                    color: Color(0xFF5B645F),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/payment1/rupee.png',
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                      semanticLabel: 'currency_rupee',
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      '1250',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth * 0.045,
                        color: Color(0xFF5B645F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: _navigateToCongratulationsPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFC9A070),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'PAY & CONFIRM YOUR ORDER',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget paymentMethodItem(BuildContext context, String title, String asset) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: GestureDetector(
        onTap: () {
          if (title == 'Visa') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CardDetailsPage()),
            );
          } else if (title == 'UPI Payment') {
            _toggleUPIInput();
          } else if (title == 'Cash on Delivery') {
            _navigateToCongratulationsPage();
          }
        },
        child: Row(
          children: [
            Image.asset(
              asset,
              width: screenWidth * 0.09,
              height: screenWidth * 0.09,
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: screenWidth * 0.045,
                  color: Color(0xFF1F1F1F),
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: screenWidth * 0.04),
          ],
        ),
      ),
    );
  }
}
