// lib/pages/restaurant_detail.dart

import 'package:flutter/material.dart';
import 'package:responsi/data/restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;
  final Function(Restaurant) toggleFavorite;
  final bool isFavorite;

  RestaurantDetailPage({
    required this.restaurant,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool? _isFavorite; // Menyimpan status favorit lokal

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite; // Inisialisasi status favorit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 36, 36),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mengatur tinggi gambar agar lebih kecil
            Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
              fit: BoxFit.cover,
              height: 200, // Mengatur tinggi gambar
              width:
                  double.infinity, // Mengatur lebar gambar agar memenuhi ruang
            ),
            SizedBox(height: 16),
            Text(
              widget.restaurant.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'City: ${widget.restaurant.city}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Rating: ${widget.restaurant.rating}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', // Ganti dengan deskripsi yang sesuai jika ada.
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Ikon love di dalam halaman detail
            Center(
              child: IconButton(
                icon: Icon(
                  _isFavorite! ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite! ? Colors.red : Colors.grey,
                  size: 30, // Ukuran ikon
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite =
                        !_isFavorite!; // Mengubah status favorit lokal
                  });
                  widget.toggleFavorite(
                      widget.restaurant); // Memanggil fungsi toggle
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
