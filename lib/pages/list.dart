// lib/pages/list_page.dart

import 'package:flutter/material.dart';
import 'package:responsi/data/restaurant.dart';
import 'package:responsi/pages/favorite.dart'; // Pastikan nama file sesuai
import 'package:responsi/pages/restaurant_detail.dart';
import 'package:responsi/services/api.dart';

class ListPage extends StatefulWidget {
  final String username;
  ListPage({required this.username});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Restaurant> _restaurant = [];
  List<Restaurant> _favorites = [];

  @override
  void initState() {
    super.initState();
    _fetchRestaurant();
  }

  Future<void> _fetchRestaurant() async {
    try {
      final data = await API.getRestaurant();
      setState(() {
        _restaurant = (data['restaurants'] as List)
            .map((json) => Restaurant.fromJson(json))
            .toList();
      });
    } catch (e) {
      print("Error fetching restaurants: $e");
    }
  }

  void _toggleFavorite(Restaurant restaurant) {
    setState(() {
      if (_favorites.contains(restaurant)) {
        _favorites.remove(restaurant);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${restaurant.name} removed from favorites'),
          ),
        );
      } else {
        _favorites.add(restaurant);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${restaurant.name} added to favorites'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hai,  ${widget.username}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 42, 36, 36),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(
                    favorites: _favorites,
                    toggleFavorite: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _restaurant.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _restaurant.length,
              itemBuilder: (context, index) {
                final restaurant = _restaurant[index];
                final isFavorite = _favorites.contains(restaurant);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailPage(
                          restaurant: restaurant,
                          toggleFavorite: _toggleFavorite,
                          isFavorite: isFavorite,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[200],
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            restaurant.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                            restaurant.city,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              _toggleFavorite(restaurant);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
