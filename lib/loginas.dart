import 'package:flutter/material.dart';
import 'package:flutter_application_1/ChefLoginWidget.dart';
import 'package:flutter_application_1/LoginPageWidget.dart';

class MainloginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var textScaleFactor =
        screenSize.width / 375; // Assuming a base width of 375

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(238, 221, 198, 1),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 60, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: screenSize.width * 0.07,
                      height: screenSize.width * 0.08,
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/location/arrow.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.03),
                      child: Text(
                        'LOGIN AS',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 35 * textScaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginpageWidget()),
                        );
                      },
                      child: CircleAvatar(
                        radius: screenSize.width * 0.27,
                        backgroundImage:
                            AssetImage('assets/images/loginas/customer.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Text(
                      'CUSTOMER',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 25 * textScaleFactor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChefLoginWidget()),
                        );
                      },
                      child: CircleAvatar(
                        radius: screenSize.width * 0.27,
                        backgroundImage:
                            AssetImage('assets/images/loginas/chef.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Text(
                      'CHEF',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 25 * textScaleFactor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationAccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var textScaleFactor =
        screenSize.width / 375; // Assuming a base width of 375

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(238, 221, 198, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            Image.asset(
              'assets/images/location/accloc.png',
              width: screenSize.width * 0.4,
              height: screenSize.width * 0.4,
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenSize.height * 0.11),
            Container(
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.08,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(201, 145, 86, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainloginWidget()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ACCESS LOCATION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16 * textScaleFactor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'HOMELY WILL ACCESS YOUR LOCATION ONLY WHILE USING THE APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(100, 105, 130, 1),
                  fontFamily: 'Sen',
                  fontSize: 16 * textScaleFactor,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
