import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/kitchen.dart';
import 'package:flutter_application_1/widgets/orders.dart';
import 'package:flutter_application_1/models/category.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference kitchensCollection =
      FirebaseFirestore.instance.collection('kitchens');

  Future<QuerySnapshot> getTopRatedKitchens() async {
    return await kitchensCollection
        .orderBy('rating', descending: true)
        .limit(5)
        .get();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchCategoryDishes(
      String category) async {
    try {
      QuerySnapshot kitchensSnapshot =
          await _firestore.collection('kitchens').get();
      List<Map<String, dynamic>> allItems = [];

      for (var kitchen in kitchensSnapshot.docs) {
        QuerySnapshot itemsSnapshot = await _firestore
            .collection('kitchens')
            .doc(kitchen.id)
            .collection('items')
            .where('category_id', isEqualTo: category)
            .get();

        var items = itemsSnapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['kitchen_id'] = kitchen.id; // Optionally, include kitchen ID
          return data;
        }).toList();

        // Debug log for fetched items
        debugPrint('Kitchen ID: ${kitchen.id}, Items: $items');

        allItems.addAll(items);
      }

      debugPrint('All Items: $allItems');
      return allItems;
    } catch (e) {
      debugPrint('Error fetching category dishes: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await usersCollection.doc(uid).get();
  }

  Future<List<OrderCard>> getOngoingOrdersForUser(String userId) async {
    try {
      // Get the user document reference
      DocumentReference userDocRef = usersCollection.doc(userId);

      // Get the snapshot of the user document
      DocumentSnapshot userSnapshot = await userDocRef.get();

      // Extract the ongoing orders list from the user document
      List<Map<String, dynamic>> ongoingOrders =
          List<Map<String, dynamic>>.from(userSnapshot['ongoing_orders'] ?? []);

      // Get timestamp from user document
      Timestamp timestamp = userSnapshot['timestamp'];

      // Map each ongoing order to an OrderCard instance
      List<OrderCard> orderCards = ongoingOrders.map((order) {
        num totalQuantity = 0;
        List<Map<String, dynamic>> items =
            List<Map<String, dynamic>>.from(order['items'] ?? []);
        items.forEach((item) {
          totalQuantity += item['quantity'] ?? 0;
        });

        // Format timestamp to display date
        DateTime date = timestamp.toDate();

        return OrderCard(
          imageUrl: order['imageUrl'] ?? '',
          name: order['kitchen_name'] ?? '',
          price: order['price'] ?? '',
          items: totalQuantity.toString() ?? '',
          orderId: order['order_id'] ?? '',
          button1Text: order['button1Text'] ?? '',
          button2Text: order['button2Text'] ?? '',
          date: '${date.day}/${date.month}/${date.year}',
          uid: userId, // Format as needed
        );
      }).toList();

      return orderCards;
    } catch (e) {
      print('Error getting ongoing orders: $e');
      return [];
    }
  }

  Future<String> fetchAddress(String userId, String addressType) async {
    try {
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
      if (userSnapshot.exists) {
        List<dynamic> addresses = userSnapshot['addresses'] ?? [];
        Map<String, dynamic>? address = addresses.firstWhere(
          (addr) => addr['type'] == addressType,
          orElse: () => null,
        );

        if (address != null) {
          return address['address'];
        } else {
          return 'Address type $addressType not found';
        }
      } else {
        return 'User document does not exist';
      }
    } catch (e) {
      print('Error fetching address: $e');
      return 'Error fetching address';
    }
  }

  Future<String> fetchUserName(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot['name'] ??
            'Name not found'; // Assuming 'name' is the field name in Firestore
      } else {
        return 'User document does not exist';
      }
    } catch (e) {
      print('Error fetching user name: $e');
      return 'Error fetching user name';
    }
  }

  Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data()
            as Map<String, dynamic>?; // Return user data as a Map
      } else {
        print('User document for ID $userId does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<List<OrderCard>> getHistoryOrdersForUser(String userId) async {
    try {
      // Get the user document reference
      DocumentReference userDocRef = usersCollection.doc(userId);

      // Get the snapshot of the user document
      DocumentSnapshot userSnapshot = await userDocRef.get();

      // Extract the ongoing orders list from the user document
      List<Map<String, dynamic>> historyOrders =
          List<Map<String, dynamic>>.from(userSnapshot['order_history'] ?? []);

      // Get timestamp from user document
      Timestamp timestamp = userSnapshot['timestamp'];

      // Map each ongoing order to an OrderCard instance
      List<OrderCard> orderCards = historyOrders.map((order) {
        num totalQuantity = 0;
        List<Map<String, dynamic>> items =
            List<Map<String, dynamic>>.from(order['items'] ?? []);
        items.forEach((item) {
          totalQuantity += item['quantity'] ?? 0;
        });

        // Format timestamp to display date
        DateTime date = timestamp.toDate();

        return OrderCard(
          imageUrl: order['imageUrl'] ?? '',
          name: order['kitchen_name'] ?? '',
          price: order['price'] ?? '',
          items: totalQuantity.toString() ?? '',
          orderId: order['order_id'] ?? '',
          button1Text: order['button1Text'] ?? '',
          button2Text: order['button2Text'] ?? '',
          date: '${date.day}/${date.month}/${date.year}',
          uid: userId, // Format as needed
        );
      }).toList();

      return orderCards;
    } catch (e) {
      print('Error getting ongoing orders: $e');
      return [];
    }
  }

  Future<void> deleteOngoingOrder(String userId, String orderId) async {
    try {
      // Reference to the user document
      DocumentReference userDocRef = usersCollection.doc(userId);

      // Get the user document snapshot
      DocumentSnapshot userSnapshot = await userDocRef.get();

      // Retrieve ongoing orders list from the user document
      List<dynamic> ongoingOrders = userSnapshot['ongoing_orders'];

      // Remove the order with matching orderId from the list
      ongoingOrders.removeWhere((order) => order['order_id'] == orderId);

      // Update the user document with the modified ongoing orders list
      await userDocRef.update({
        'ongoing_orders': ongoingOrders,
      });

      print('Order $orderId deleted successfully');
    } catch (e) {
      print('Error deleting order: $e');
      throw e; // Propagate the error for handling elsewhere
    }
  }

  Future<void> updateUserData(
    String uid, {
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? avatarurl,
    String? bio,
    List<Map<String, dynamic>>? addresses,
    List<Map<String, dynamic>>? ongoingOrders,
    List<Map<String, dynamic>>? orderHistory,
    List<Map<String, dynamic>>? notifications,
    List<Map<String, dynamic>>? messages,
    List<Map<String, dynamic>>? mostOrderedItems,
  }) async {
    try {
      Map<String, dynamic> data = {};

      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (password != null) data['password'] = password;
      if (phoneNumber != null) data['phone_number'] = phoneNumber;
      if (avatarurl != null) data['avatarurl'] = avatarurl;
      if (bio != null) data['bio'] = bio;
      if (addresses != null) data['addresses'] = addresses;
      if (notifications != null) data['notifications'] = notifications;
      if (messages != null) data['messages'] = messages;
      if (mostOrderedItems != null) {
        data['most_ordered_items'] = mostOrderedItems;
      }

      // Add timestamp directly to the data object
      data['timestamp'] = FieldValue.serverTimestamp();

      // Handle ongoing orders and order history separately
      if (ongoingOrders != null && ongoingOrders.isNotEmpty) {
        data['ongoing_orders'] = ongoingOrders;
      }

      if (orderHistory != null && orderHistory.isNotEmpty) {
        data['order_history'] = orderHistory;
      }

      await usersCollection.doc(uid).set(data, SetOptions(merge: true));
      print('User data updated successfully');
    } catch (e) {
      print('Failed to update user data: $e');
      rethrow;
    }
  }

  Future<void> updateKitchenData(
    String kitchenId, {
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    double? rating,
    String? subtitle,
    String? kitchenimage,
    String? bio,
    String? address,
    List<Map<String, dynamic>>? ongoingOrders,
    List<Map<String, dynamic>>? orderHistory,
    List<Map<String, dynamic>>? notifications,
    List<Map<String, dynamic>>? messages,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      Map<String, dynamic> data = {};

      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (password != null) data['password'] = password;
      if (phoneNumber != null) data['phone_number'] = phoneNumber;
      if (rating != null) data['rating'] = rating;
      if (subtitle != null) data['subtitle'] = subtitle;
      if (kitchenimage != null) data['kitchenimage'] = kitchenimage;
      if (bio != null) data['bio'] = bio;
      if (address != null) data['address'] = address;
      if (notifications != null) data['notifications'] = notifications;
      if (messages != null) data['messages'] = messages;
      if (items != null) data['items'] = items;

      // Add timestamp directly to the data object
      data['timestamp'] = FieldValue.serverTimestamp();

      // Handle ongoing orders and order history separately
      if (ongoingOrders != null && ongoingOrders.isNotEmpty) {
        data['ongoing_orders'] = ongoingOrders;
      }

      if (orderHistory != null && orderHistory.isNotEmpty) {
        data['order_history'] = orderHistory;
      }

      await kitchensCollection
          .doc(kitchenId)
          .set(data, SetOptions(merge: true));
      print('Kitchen data updated successfully');
    } catch (e) {
      print('Failed to update kitchen data: $e');
      rethrow;
    }
  }

  Future<List<Kitchen>> fetchKitchensFromFirestore() async {
    List<Kitchen> kitchens = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('kitchens').get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> kitchenData = doc.data() as Map<String, dynamic>;

        // Retrieve the kitchen ID
        String kid = doc
            .id; // Assuming the ID is stored directly in Firestore document ID

        List<Map<String, dynamic>> ongoingOrders =
            List<Map<String, dynamic>>.from(
                kitchenData['ongoing_orders'] ?? []);
        List<Map<String, dynamic>> orderHistory =
            List<Map<String, dynamic>>.from(kitchenData['order_history'] ?? []);
        List<Map<String, dynamic>> notifications =
            List<Map<String, dynamic>>.from(kitchenData['notifications'] ?? []);
        List<Map<String, dynamic>> messages =
            List<Map<String, dynamic>>.from(kitchenData['messages'] ?? []);
        List<Map<String, dynamic>> items =
            List<Map<String, dynamic>>.from(kitchenData['items'] ?? []);

        kitchens.add(Kitchen(
          kid: kid, // Assign the kitchen ID here
          name: kitchenData['name'],
          email: kitchenData['email'],
          phoneNumber: kitchenData['phone_number'],
          rating: kitchenData['rating'] ?? 0.0,
          subtitle: kitchenData['subtitle'] ?? '',
          kitchenImage: kitchenData['kitchenimage'],
          bio: kitchenData['bio'],
          address: kitchenData['address'],
          ongoingOrders: ongoingOrders,
          orderHistory: orderHistory,
          notifications: notifications,
          messages: messages,
          items: items,
        ));
      });

      // Sort kitchens by rating in descending order
      kitchens.sort((a, b) => b.rating.compareTo(a.rating));

      return kitchens;
    } catch (e) {
      print('Error fetching kitchens: $e');
      return []; // Return an empty list if there's an error
    }
  }
}

class KitchenService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchKitchenData(String kitchenId) async {
    DocumentSnapshot doc =
        await _db.collection('kitchens').doc(kitchenId).get();
    return doc.data() as Map<String, dynamic>;
  }
}
