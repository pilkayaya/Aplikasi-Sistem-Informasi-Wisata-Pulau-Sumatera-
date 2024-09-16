import 'package:flutter/material.dart';
import 'package:wisata_app/core/session_manager.dart';
import 'package:wisata_app/ui/home_page.dart';

class ProfilePage extends StatelessWidget {
  final SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Color(0xFF1A5319))),
        backgroundColor: Colors.white,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(sessionManager.getActiveFoto() ?? ''),
              ),
              SizedBox(height: 16),
              Text(
                '${sessionManager.getActiveFirstname()} ${sessionManager.getActiveLastname()}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A5319)),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ProfileInfoCard(
                      title: 'First Name',
                      value: sessionManager.getActiveFirstname() ?? '',
                    ),
                    SizedBox(height: 16),
                    ProfileInfoCard(
                      title: 'Last Name',
                      value: sessionManager.getActiveLastname() ?? '',
                    ),
                    SizedBox(height: 16),
                    ProfileInfoCard(
                      title: 'Email',
                      value: sessionManager.getActiveEmail() ?? '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Set current index to Profile
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfoCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFD8D9DA),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
