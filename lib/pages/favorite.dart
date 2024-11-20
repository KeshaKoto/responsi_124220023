// lib/pages/favorites.dart

import 'package:flutter/material.dart';
import 'package:responsi/data/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatelessWidget {
  final List<Restaurant> favorites;
  final Function(Restaurant) toggleFavorite;

  FavoritesPage({required this.favorites, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final restaurant = favorites[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(restaurant.name),
                    subtitle: Text(restaurant.city),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        _removeFavorite(
                            context, restaurant); // Menghapus dari favorit
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _removeFavorite(
      BuildContext context, Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites') ?? [];

    // Hapus ID restoran dari daftar favorit
    favoriteIds.remove(restaurant.id);
    await prefs.setStringList('favorites', favoriteIds);

    // Notifikasi UI dan penghapusan dari daftar favorit
    toggleFavorite(restaurant); // Memanggil fungsi toggle untuk memperbarui UI
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${restaurant.name} removed from favorites'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
