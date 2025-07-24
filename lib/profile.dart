import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp/highlight.dart';
import 'dart:io';
import 'package:fyp/technique.dart';
import 'package:fyp/home.dart';
import 'package:fyp/training.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // State variables
  String name = "Player Name";
  File? profileImage;
  List<DateTime> winDates = [];
  List<DateTime> upcomingMatches = [];

  // Helper method to format dates
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white, size: 28),
                    onPressed: () {
                      // Settings action
                    },
                  ),
                ],
              ),
            ),
          ),
          // Profile Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage:
                            profileImage != null ? FileImage(profileImage!) : null,
                            child: profileImage == null
                                ? Icon(Icons.person, size: 60, color: Colors.white)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 120,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text("Take a Photo"),
                                          onTap: () {
                                            Navigator.pop(context);
                                            pickImage(ImageSource.camera);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.photo_library),
                                          title: Text("Choose from Gallery"),
                                          onTap: () {
                                            Navigator.pop(context);
                                            pickImage(ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Editable Profile Name
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      controller: TextEditingController(text: name),
                    ),
                    SizedBox(height: 24),

                    // Track Wins Section
                    Text(
                      'Track Wins',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            winDates.add(pickedDate);
                          });
                        }
                      },
                      child: Text('Add Win Date'),
                    ),
                    SizedBox(height: 8),
                    if (winDates.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: winDates
                            .map((date) => Text(
                          "- ${formatDate(date)}",
                          style: TextStyle(fontSize: 16),
                        ))
                            .toList(),
                      ),
                    if (winDates.isEmpty)
                      Text(
                        "No wins tracked yet.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    SizedBox(height: 24),

                    // Upcoming Matches Section
                    Text(
                      'Upcoming Matches',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            upcomingMatches.add(pickedDate);
                          });
                        }
                      },
                      child: Text('Add Match Date'),
                    ),
                    SizedBox(height: 8),
                    if (upcomingMatches.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: upcomingMatches
                            .map((date) => Text(
                          "- ${formatDate(date)}",
                          style: TextStyle(fontSize: 16),
                        ))
                            .toList(),
                      ),
                    if (upcomingMatches.isEmpty)
                      Text(
                        "No upcoming matches.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                  ],
                ),
              ),
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
                // Community Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Highlight()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
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
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.blue.shade200, blurRadius: 10, offset: Offset(0, 5)),
                      ],
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