import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/highlight.dart';
import 'package:fyp/home.dart';
import 'package:fyp/profile.dart';
import 'package:fyp/training.dart';
import 'package:sqflite/sqflite.dart'; // Or any database package you are using


class Technique extends StatefulWidget {
  @override
  _TechniqueState createState() => _TechniqueState();
}

class _TechniqueState extends State<Technique> {
  double _progress = 0.0;
  List<bool> beginnerTasks = [false, false, false, false, false];
  List<bool> intermediateTasks = [false, false, false, false, false];
  List<bool> advancedTasks = [false, false, false, false, false];

  void _updateProgress() {
    int totalTasks = beginnerTasks.length + intermediateTasks.length + advancedTasks.length;
    int completedTasks = beginnerTasks.where((task) => task).length +
        intermediateTasks.where((task) => task).length +
        advancedTasks.where((task) => task).length;
    setState(() {
      _progress = completedTasks / totalTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Header with gradient background
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
                    'Technique',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Settings"),
                          content: Text("Settings control tapped!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Close"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Training Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Training Progression',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Duration: Spend 4-6 weeks mastering one level before moving to the next.',
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                    Text(
                      'Frequency: Train 3-5 times per week, focusing on specific skills each session.',
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                    Text(
                      'Evaluation: Conduct mock matches to test skills and adjust training accordingly.',
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 32),

                    // Progress Bar
                    Text(
                      'Training Progress:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: _progress,
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.lightBlueAccent],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Expansion Tiles for tasks
                    ExpansionTile(
                      title: Text('Beginner'),
                      children: [
                        _buildTaskChecklist(beginnerTasks, [
                          'Juggling Basics: Use one foot to keep the ball in the air for 10 consecutive touches.',
                          'Stationary Wall Drill: Pass the ball against a wall using the inside of the foot.',
                          'Inside Kick Serve: Practice serving with the inside of the foot.',
                          'Toe Kick Serve: Use the toe to gently tap the ball over the net.',
                          'Basic Contact Practice: Toss the ball lightly and try to spike using the top of the foot.',
                        ]),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Intermediate'),
                      children: [
                        _buildTaskChecklist(intermediateTasks, [
                          'Multi-Body Juggling: Alternate between foot, knee, and head to keep the ball in the air.',
                          'Directional Wall Passing: Pass the ball against a wall but aim for specific areas.',
                          'Powerful Inside Kick Serve: Increase power while maintaining accuracy.',
                          'Toe Kick Serve Precision: Practice targeting corners or sidelines.',
                          'Jump Spike Drill: Practice leaping and spiking the ball at its peak.',
                        ]),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Advanced'),
                      children: [
                        _buildTaskChecklist(advancedTasks, [
                          'Controlled Chaos Drill: Practice ball control while moving around the court.',
                          'High-Speed Passing: Use a ball feeder to deliver balls at various speeds and angles.',
                          'Roll Spike Serve: Practice the roll spike serve by flipping mid-air and striking the ball over the net.',
                          'Deceptive Serve: Combine power with unpredictability.',
                          'Sunback Spike: Practice the backward arching motion to execute the sunback spike.',
                        ]),
                      ],
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

  Widget _buildTaskChecklist(List<bool> taskList, List<String> tasks) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(tasks[index]),
          value: taskList[index],
          onChanged: (bool? value) {
            setState(() {
              taskList[index] = value ?? false;
              _updateProgress();
            });
          },
        );
      },
    );
  }
}