import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/review/review_bloc.dart';
import '../params/review_param.dart';
import '../response/review_response.dart';
import 'home_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  final TextEditingController _komentarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: -15.0, // Jarak horizontal antara ikon
              runSpacing: 1.0, // Jarak vertical antara baris ikon
              children: [
                for (int i = 1; i <= 10; i++)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = i;
                      });
                    },
                    icon: Icon(
                      _rating >= i ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 25.0, // Ukuran ikon bintang
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ulasan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _komentarController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final reviewParam = ReviewParam(
                    userProfileId: 1, // Ganti sesuai ID pengguna
                    objekWisata: 'objek_wisata', // Ganti sesuai objek wisata
                    komentar: _komentarController.text,
                    rating: _rating.toString(),
                  );

                  context.read<ReviewBloc>().add(AddReview(reviewParam));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text('Post'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
          }
        },
      ),
    );
  }
}
