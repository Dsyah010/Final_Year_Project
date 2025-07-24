import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'training.dart';
import 'package:fyp/technique.dart';
import 'package:sqflite/sqflite.dart'; // Or any database package you are using


class Highlight extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      "user": "John Doe",
      "content": "Team A vs Team B | 3-2 | Amazing rally in the final set!",
      "imageUrl": "https://via.placeholder.com/150",
      "date": "Jan 5, 2025",
    },
    {
      "user": "Jane Smith",
      "content": "Team C's Trick Shots Compilation | Must Watch!",
      "imageUrl": "https://via.placeholder.com/150",
      "date": "Jan 4, 2025",
    },
    {
      "user": "Alex Kim",
      "content": "Best Moments from the Championship Finals.",
      "imageUrl": "https://via.placeholder.com/150",
      "date": "Jan 3, 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Container
          Container(
            width: MediaQuery.of(context).size.width,
            height: 128,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Highlight',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Navigate to Settings page (implement Settings page separately)
                    },
                  ),
                ],
              ),
            ),
          ),
          // Filters and Sorting
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  hint: Text("Filter by Team"),
                  items: ["Team A", "Team B", "Team C"]
                      .map((team) => DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  ))
                      .toList(),
                  onChanged: (value) {
                    // Handle filter logic here
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.trending_up),
                      onPressed: () {
                        // Sort by Most Viewed
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        // Sort by Recent Uploads
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {
                        // Sort by Best Moments
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Main Social Feed Content
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return HighlightCard(
                  user: post['user']!,
                  content: post['content']!,
                  imageUrl: post['imageUrl']!,
                  date: post['date']!,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        elevation: 4,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Technique Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Technique()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.directions_run,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                // Training Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Training()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                // Home Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                // Community Button (Selected)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.blue.shade200, blurRadius: 10, offset: Offset(0, 5))
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.ondemand_video,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                // Profile Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HighlightCard extends StatelessWidget {
  final String user;
  final String content;
  final String imageUrl;
  final String date;

  const HighlightCard({
    required this.user,
    required this.content,
    required this.imageUrl,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Icon(
                  Icons.play_circle_filled,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              date,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.thumb_up_alt_outlined, size: 20, color: Colors.grey),
                Icon(Icons.comment_outlined, size: 20, color: Colors.grey),
                Icon(Icons.share, size: 20, color: Colors.grey),
                Icon(Icons.bookmark_border, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}