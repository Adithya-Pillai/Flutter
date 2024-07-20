import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/chats.dart';
import 'package:flutter_application_1/widgets/orders.dart';

class ChefOngoingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const OrderCard(
          imageUrl: 'assets/images/Home/sharath.png',
          name: "Reddy's Kitchen",
          price: 'Rs.520',
          items: '06 Items',
          orderId: '#162432',
          button1Text: 'Order prepared',
          button2Text: 'Cancel',
          uid:'',
        ),
        const OrderCard(
          imageUrl: 'assets/images/Home/idli.png',
          name: 'Sree Devi House',
          price: 'Rs.300',
          items: '02 Items',
          orderId: '#242432',
          button1Text: 'Order prepared',
          button2Text: 'Cancel',
          uid:'',
        ),
        const OrderCard(
          imageUrl: 'assets/images/Home/meals.png',
          name: 'Sharma aunties kitchen',
          price: 'Rs.250',
          items: '01 Items',
          orderId: '#240112',
          button1Text: 'Order Prepared',
          button2Text: 'Cancel',
          uid:'',
        ),
      ],
    );
  }
}

class ChefHistoryOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OrderCard(
          imageUrl: 'assets/images/Home/sharath.png',
          name: "Reddy's Kitchen",
          price: 'Rs.520',
          items: '03 Items',
          orderId: '#162432',
          date: '29 JAN, 12:30',
          button1Text: 'Message',
          button2Text: 'Reorder',
          uid:''
        ),
        OrderCard(
          imageUrl: 'assets/images/Home/idli.png',
          name: 'Sree Devi House',
          price: 'Rs.300',
          items: '02 Items',
          orderId: '#242432',
          date: '30 JAN, 12:15',
          button1Text: 'Message',
          button2Text: 'Re-Order',
          uid: '',
        ),
        OrderCard(
          imageUrl: 'assets/images/Home/meals.png',
          name: 'Sharma aunties kitchen',
          price: 'Rs.250',
          items: '01 Items',
          orderId: '#240112',
          date: '30 JAN, 12:30',
          button1Text: 'Message',
          button2Text: 'Re-Order',
          uid:''
        ),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: []);
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatMessage(
          senderName: 'Swathi Shetty',
          message: 'Yes dear thank you for your review',
          time: '19:37',
          avatarImagePath: 'assets/images/Chat/chat1.png',
        ),
        ChatMessage(
          senderName: 'Pooja Sharma',
          message: 'Ok 😊',
          time: '19:37',
          avatarImagePath: 'assets/images/Chat/chat2.png',
        ),
        ChatMessage(
          senderName: 'Priya Dev',
          message: 'Superb food aunty',
          time: '19:37',
          avatarImagePath: 'assets/images/Chat/chat3.png',
        ),
        ChatMessage(
          senderName: 'Rameshwari M',
          message: 'Paneer recipe pls?',
          time: '19:37',
          avatarImagePath: 'assets/images/Chat/chat4.png',
        ),
      ],
    );
  }
}
