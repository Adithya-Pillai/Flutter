import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  String _label = 'Home';
  LatLng _selectedLocation = LatLng(12.9716, 77.5946); // Default to Bangalore
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    loc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _selectedLocation =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    // Update address based on current location
    await _updateAddress(_selectedLocation);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _selectedLocation = position.target;
  }

  Future<void> _updateAddress(LatLng location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      _addressController.text =
          '${placemark.street}, ${placemark.locality} ${placemark.postalCode}';
      _streetController.text = placemark.street ?? '';
      _postCodeController.text = placemark.postalCode ?? '';
    }
  }

  void _onLocationSelected(LatLng location) async {
    setState(() {
      _selectedLocation = location;
    });
    await _updateAddress(_selectedLocation);
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
          'Add Address',
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
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _selectedLocation,
                      zoom: 15,
                    ),
                    onCameraMove: _onCameraMove,
                    onTap: _onLocationSelected,
                    markers: {
                      Marker(
                        markerId: MarkerId('selected-location'),
                        position: _selectedLocation,
                      ),
                    },
                  ),
                  Center(
                    child:
                        Icon(Icons.location_pin, color: Colors.red, size: 50),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      'Move to edit location',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'ADDRESS',
                prefixIcon: Icon(Icons.location_on),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _streetController,
                    decoration: InputDecoration(
                      labelText: 'STREET',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _postCodeController,
                    decoration: InputDecoration(
                      labelText: 'POST CODE',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _apartmentController,
              decoration: InputDecoration(
                labelText: 'APARTMENT',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLabelButton('Home', Colors.red),
                _buildLabelButton('Work', Colors.purple),
                _buildLabelButton('Other', Colors.grey),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
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
                  // Handle save location
                },
                child: Text(
                  'SAVE LOCATION',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelButton(String label, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _label == label ? color : Colors.grey[200],
        foregroundColor: _label == label ? Colors.white : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        setState(() {
          _label = label;
        });
      },
      child: Text(label),
    );
  }
}
