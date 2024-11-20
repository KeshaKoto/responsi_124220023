import 'package:flutter/material.dart';
import 'package:responsi/data/restaurant.dart';
import 'package:responsi/services/api.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int restaurantId;

  RestaurantDetailsPage(this.restaurantId);

  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  Restaurant? _restaurant;

  @override
  void initState() {
    super.initState();
    _fetchRestaurantDetails();
  }

  Future<void> _fetchRestaurantDetails() async {
    try {
      final data = await API.getRestaurantDetails(widget.restaurantId);
      setState(() {
        _restaurant = Restaurant.fromJson(data);
      });
    } catch (e) {
      print('Error fetching article details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_restaurant == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Restaurants Details'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_restaurant!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_restaurant!.name),
            SizedBox(height: 16.0),
            Text(_restaurant!.city),
            SizedBox(height: 16.0),
            Text(_restaurant!.description),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
