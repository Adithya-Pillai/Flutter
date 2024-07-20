import 'package:flutter/material.dart';
import 'foodlist.dart';

class AddNewItemScreen extends StatefulWidget {
  @override
  _AddNewItemScreenState createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final Color backgroundColor = Color(0xFFEEDDC6);
  final Color bottomBarColor = Color(0xFF3C260C);
  int? _selectedOption = 0;

  List<String> selectedBasicAllergens = [];
  List<String> selectedFruitAllergens = [];

  void _resetSelections() {
    setState(() {
      selectedBasicAllergens.clear();
      selectedFruitAllergens.clear();
    });
  }

  void _toggleSelection(String allergen, List<String> selectedList) {
    setState(() {
      if (selectedList.contains(allergen)) {
        selectedList.remove(allergen);
      } else {
        selectedList.add(allergen);
      }
    });
  }

  Color _getChipColor(String allergen, List<String> selectedList) {
    if (selectedList.contains(allergen)) {
      return Colors.brown[400]!;
    } else {
      return Colors.brown[100]!;
    }
  }

  void _submitItem() {
    // Navigate to FoodListScreen after submitting the item
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back arrow
        title: Text('Add New Items', style: TextStyle(color: Colors.brown)),
        actions: [
          TextButton(
            onPressed: _resetSelections,
            child: Text(
              'RESET',
              style: TextStyle(color: Colors.brown),
            ),
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ITEM NAME',
                  style: TextStyle(fontSize: 16, color: Colors.brown)),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mozalichiken Halim',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text('UPLOAD PHOTO/VIDEO',
                  style: TextStyle(fontSize: 16, color: Colors.brown)),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/icons/food.jpg'), // replace with your image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: Center(
                              child: Icon(Icons.add,
                                  color: Color.fromARGB(255, 231, 185, 130))),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: Center(
                              child: Icon(Icons.add,
                                  color: Color.fromARGB(255, 231, 185, 130))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('PRICE',
                  style: TextStyle(fontSize: 16, color: Colors.brown)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        Text('Pick up', style: TextStyle(color: Colors.brown)),
                        Radio<int>(
                          value: 1,
                          groupValue: _selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                        Text('Delivery', style: TextStyle(color: Colors.brown)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('ALLERGEN INFORMATION',
                  style: TextStyle(fontSize: 16, color: Colors.brown)),
              SizedBox(height: 8),
              Text('Basic',
                  style: TextStyle(fontSize: 14, color: Colors.brown)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSelectableChip('Salt', 'assets/images/icons/salt.png',
                      selectedBasicAllergens),
                  _buildSelectableChip(
                      'Chicken',
                      'assets/images/icons/chicken.png',
                      selectedBasicAllergens),
                  _buildSelectableChip('Onion', 'assets/images/icons/onion.png',
                      selectedBasicAllergens),
                  _buildSelectableChip('Garlic',
                      'assets/images/icons/garlic.png', selectedBasicAllergens),
                  _buildSelectableChip(
                      'Peppers',
                      'assets/images/icons/peppers.png',
                      selectedBasicAllergens),
                  _buildSelectableChip('Ginger',
                      'assets/images/icons/ginger.png', selectedBasicAllergens),
                ],
              ),
              SizedBox(height: 8),
              Text('Fruit',
                  style: TextStyle(fontSize: 14, color: Colors.brown)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSelectableChip(
                      'Avocado',
                      'assets/images/icons/avocado.png',
                      selectedFruitAllergens),
                  _buildSelectableChip('Apple', 'assets/images/icons/apple.png',
                      selectedFruitAllergens),
                  _buildSelectableChip(
                      'Blueberry',
                      'assets/images/icons/blueberry.png',
                      selectedFruitAllergens),
                  _buildSelectableChip(
                      'Broccoli',
                      'assets/images/icons/broccoli.png',
                      selectedFruitAllergens),
                  _buildSelectableChip('Orange',
                      'assets/images/icons/orange.png', selectedFruitAllergens),
                  _buildSelectableChip('Walnut',
                      'assets/images/icons/walnut.png', selectedFruitAllergens),
                ],
              ),
              SizedBox(height: 16),
              Text('DETAILS',
                  style: TextStyle(fontSize: 16, color: Colors.brown)),
              SizedBox(height: 8),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableChip(
      String label, String iconPath, List<String> selectedList) {
    return GestureDetector(
      onTap: () => _toggleSelection(label, selectedList),
      child: Chip(
        label: Text(label),
        avatar: Image.asset(iconPath),
        backgroundColor: _getChipColor(label, selectedList),
      ),
    );
  }
}
