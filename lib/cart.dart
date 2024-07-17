import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MaterialApp(
    home: FoodOrderPage(),
  ));
}

class FoodOrderPage extends StatefulWidget {
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  int counter = 0; // Initialize counter to 0
  List<CartItem> cartItems = []; // Initialize cartItems as empty list

  @override
  void initState() {
    super.initState();
    // Example: Fetch cart items from backend or set initial state
    fetchCartItems(); // Example method to fetch items
  }

  // Method to fetch cart items from backend or set initial state
  void fetchCartItems() {
    // Example: Replace with actual logic to fetch data from backend or state transfer
    List<CartItem> fetchedItems = [
      CartItem(
        productName: "Grilled Salmon",
        productPrice: 15.16,
        productImage: "assets/images/Home/idli.png",
        productCartQuantity: 2,
        screenWidth: Get.mediaQuery.size.width,
      ),
      CartItem(
        productName: "Meat vegetable",
        productPrice: 6.08,
        productImage: "assets/images/Home/idli.png",
        productCartQuantity: 5,
        screenWidth: Get.mediaQuery.size.width,
      ),
    ];

    setState(() {
      cartItems = fetchedItems; // Update cartItems with fetched data
      counter = fetchedItems.length; // Update counter
    });
  }

  // Method to add item to cart
  void addToCart(CartItem newItem) {
    setState(() {
      bool found = false;
      for (int i = 0; i < cartItems.length; i++) {
        if (cartItems[i].productName == newItem.productName) {
          cartItems[i].productCartQuantity++;
          found = true;
          break;
        }
      }
      if (!found) {
        cartItems.add(newItem);
      }
      counter++;
    });
  }

  // Method to remove item from cart
  void removeFromCart(int index) {
    setState(() {
      if (cartItems[index].productCartQuantity > 1) {
        cartItems[index].productCartQuantity--;
      } else {
        cartItems.removeAt(index);
      }
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    debugPrint('Screen Width: $screenWidth');
    debugPrint('Screen Height: $screenHeight');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 221, 198, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF3a3737),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            // Wrap the title with Center widget
            child: Text(
              "Item Carts",
              style: TextStyle(
                color: Color(0xFF3a3737),
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.05,
                fontFamily: 'Poppins', // Set font family
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: Color.fromRGBO(238, 221, 198, 1),
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionTitle(title: "Your Food Cart", screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              Column(
                children: cartItems.map((item) {
                  int index = cartItems.indexOf(item);
                  return CartItem(
                    productName: item.productName,
                    productPrice: item.productPrice,
                    productImage: item.productImage,
                    productCartQuantity: item.productCartQuantity,
                    screenWidth: screenWidth,
                    onRemove: () {
                      removeFromCart(index);
                    },
                    onAdd: () {
                      addToCart(item); // Add the same item again
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: screenHeight * 0.02),
              PromoCodeWidget(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              TotalCalculationWidget(
                cartItems: cartItems,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              SectionTitle(title: "Payment Method", screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              PaymentMethodWidget(screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final double screenWidth;

  SectionTitle({required this.title, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: screenWidth * 0.01),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFF3a3a3b),
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins', // Set font family
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  final double screenWidth;

  PaymentMethodWidget({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: screenWidth * 0.15,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: screenWidth * 0.01,
              right: screenWidth * 0.03,
              top: screenWidth * 0.01,
              bottom: screenWidth * 0.01),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/Home/idli.png",
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                "Credit/Debit Card",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins', // Set font family
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalCalculationWidget extends StatelessWidget {
  final List<CartItem> cartItems;
  final double screenWidth;

  TotalCalculationWidget({required this.cartItems, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
        0,
        (previousValue, item) =>
            previousValue + (item.productPrice * item.productCartQuantity));

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenWidth * 0.01),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenWidth * 0.015),
              ...cartItems.map((item) {
                return CalculationRow(
                  itemName: item.productName,
                  itemPrice:
                      "\$${(item.productPrice * item.productCartQuantity).toStringAsFixed(2)}",
                  screenWidth: screenWidth,
                  onRemove: item.onRemove,
                  onAdd: item.onAdd,
                );
              }).toList(),
              SizedBox(height: screenWidth * 0.015),
              CalculationRow(
                itemName: "Total",
                itemPrice: "\$${total.toStringAsFixed(2)}",
                isTotal: true,
                screenWidth: screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculationRow extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final bool isTotal;
  final double screenWidth;
  final VoidCallback? onRemove;
  final VoidCallback? onAdd;

  CalculationRow({
    required this.itemName,
    required this.itemPrice,
    this.isTotal = false,
    required this.screenWidth,
    this.onRemove,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            itemName,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Color(0xFF3a3a3b),
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              fontFamily: 'Poppins', // Set font family
            ),
            textAlign: TextAlign.left,
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: onRemove,
                color: Colors.red,
                iconSize: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                itemPrice,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Color(0xFF3a3a3b),
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                  fontFamily: 'Poppins', // Set font family
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(width: screenWidth * 0.02),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: onAdd,
                color: Colors.green,
                iconSize: screenWidth * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PromoCodeWidget extends StatelessWidget {
  final double screenWidth;

  PromoCodeWidget({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenWidth * 0.01),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter promo code",
                    hintStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Color(0xFFbcbcbc),
                      fontFamily: 'Poppins', // Set font family
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Color(0xFF3a3a3b),
                    fontFamily: 'Poppins', // Set font family
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    color: Color(0xFF3a3a3b),
                    size: screenWidth * 0.08,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productImage;
  int productCartQuantity;
  final double screenWidth;
  final VoidCallback? onRemove;
  final VoidCallback? onAdd;

  CartItem({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productCartQuantity,
    required this.screenWidth,
    this.onRemove,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenWidth * 0.015),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  productImage,
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins', // Set font family
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      "\$${productPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Color(0xFF3a3a3b),
                        fontFamily: 'Poppins', // Set font family
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align buttons to the right
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: onRemove,
                          color: Colors.red,
                          iconSize: screenWidth * 0.08,
                        ),
                        Text(
                          "Qty: $productCartQuantity",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Color(0xFF3a3a3b),
                            fontFamily: 'Poppins', // Set font family
                          ),
                          textAlign: TextAlign.left,
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: onAdd,
                          color: Colors.green,
                          iconSize: screenWidth * 0.08,
                        ),
                      ],
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
