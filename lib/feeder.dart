import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as custom_badges;
import 'package:sqflite/sqflite.dart'; // Or any database package you are using


class Feeder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TrainingPage(role: "Feeder");
  }
}

class TrainingPage extends StatefulWidget {
  final String role;

  TrainingPage({required this.role});

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final Map<String, Map<String, List<String>>> _weeklyTrainingPlan = {
    'Beginner': {
      'Day 1: Coordination and Ball Control':['Warm-Up: 10 minutes jogging + dynamic stretching','Ladder drills: 3 sets x 5 variations (e.g., single steps, lateral steps)','Wall toss and thigh control: 10 minutes (use thighs to control the ball and return it to the wall)','Static ball setting: Practice setting the ball straight up with your foot for 10 minutes.','Cool Down: Hamstring, quad, and calf stretches'],
      'Day 2: Core Strength':['Warm-Up: 5 minutes jump rope','Plank holds: 3 x 20 seconds','Side planks: 3 x 10 seconds per side','Dead bugs: 3 x 12 reps','Glute bridges: 3 x 15 reps','Cool Down: Deep breathing and core-focused stretches'],
      'Day 3: Agility and Leg Strength':['Warm-Up: Brisk walking or jogging for 5 minutes','Bodyweight squats: 3 x 12 reps','Wall sits: 3 x 20 seconds','Step-ups on a low bench: 3 x 10 per leg','Shuttle runs: 5 x 10 meters','Cool Down: Stretching hamstrings and calves'],
      'Day 4: Rest/Active Recovery':['Light walking, swimming, or yoga for 20-30 minutes'],
      'Day 5: Ball Precision':['Warm-Up: Light jogging for 5 minutes','Controlled toss and set: Practice accurately setting the ball with your foot to a partner or wall (10 minutes).','Target setting: Aim to set the ball into specific quadrants (10 sets x 5 reps).','Cool Down: Stretch and relax'],
      'Day 6: Reaction and Flexibility':['Warm-Up: Jogging in place for 5 minutes','Reaction drills: Partner tosses a ball, and Feeder reacts to set it accurately (3 x 10 reps).','Seated forward fold: Hold for 30 seconds, 3 sets.','Butterfly stretch: Hold for 30 seconds, 3 sets.','Cool Down: Breathing exercises and foam rolling'],
      'Day 7: Active Recovery':['Light cardio (e.g., cycling) and foam rolling for muscle recovery'],

    },
    'Intermediate': {
      'Day 1: Advanced Agility': ['Warm-Up: 10 minutes jogging + dynamic stretching','Ladder drills: 3 x 5 advanced variations (e.g., in-and-out steps, zigzags)','Cone drills: Zigzag through cones (5 x 10 meters).','Lateral hops over cones: 3 x 15 seconds','Cool Down: Stretching'],
      'Day 2: Core and Stability': ['Warm-Up: Jump rope for 5 minutes','Side planks with leg lift: 3 x 10 seconds per side','Russian twists: 3 x 15 reps (with light weight, if available)','Stability ball rollouts: 3 x 12 reps','Bicycle crunches: 3 x 20 reps','Cool Down: Core-focused stretches'],
      'Day 3: Power and Strength': ['Warm-Up: Jogging and leg swings for 5 minutes','Weighted squats (lightweights): 3 x 10 reps','Bulgarian split squats: 3 x 10 reps per leg','Broad jumps: 3 x 10 reps','Calf raises (on an elevated surface): 3 x 15 reps','Cool Down: Stretching glutes and hamstrings'],
      'Day 4: Rest/Active Recovery': ['Light swimming, cycling, or yoga for 20-30 minutes'],
      'Day 5: Setting Accuracy': ['Warm-Up: Light jogging + dynamic stretching','High toss and set: Practice setting the ball to a partner or target at varying heights (10 sets x 10 reps).','Reaction setting: Partner tosses random balls, and Feeder reacts to set them accurately (10 minutes).','Cool Down: Stretch and foam rolling'],
      'Day 6: Combination Drills': ['Warm-Up: 10 minutes jogging + stretching','Ladder drill into setting: 3 x 10 sets','Cone drills into ball toss and set: 3 x 10 reps','Cool Down: Deep breathing and stretching'],
      'Day 7: Flexibility and Recovery': ['Full-body stretching routine','Foam rolling and light yoga for muscle recovery'],

    },
    'Advanced': {
      'Day 1: High-Intensity Agility': ['Warm-Up: High-knee jogging for 5 minutes','Ladder drills: 4 x 5 advanced variations (e.g., cross steps, hopscotch steps)','Sprint intervals: 6 x 20 meters','Single-leg lateral hops: 3 x 15 seconds per leg','Cool Down: Stretching'],
      'Day 2: Explosive Core': ['Warm-Up: Jump rope with speed changes for 5 minutes','Medicine ball slams: 3 x 12 reps','Hanging leg raises: 3 x 12 reps','Plank-to-push-up transitions: 3 x 12 reps','Side planks with arm reach: 3 x 10 reps per side','Cool Down: Core stretches'],
      'Day 3: Advanced Leg Power': ['Warm-Up: Jogging and dynamic stretching','Depth jumps: 3 x 12 reps','Explosive box jumps: 3 x 10 reps','Single-leg Bulgarian split squats (with weight): 3 x 10 reps per leg','Cool Down: Hamstring and quad stretches'],
      'Day 4: Rest/Active Recovery': ['Light swimming or yoga session'],
      'Day 5: Precision and Reaction': ['Warm-Up: Light jogging + dynamic stretching','Advanced target setting: 10 sets x 10 serves aiming at small quadrants.','Partner reaction setting: Partner tosses random balls, and Feeder must set them accurately (10 minutes).','Cool Down: Stretch and relax'],
      'Day 6: High-Intensity Circuit': ['Warm-Up: 10 minutes jogging + stretching','Lateral cone hops: 30 seconds','Jump squats: 12 reps','Ball juggling: 1 minute','Shuttle runs: 30 seconds','Cool Down: Stretch and foam rolling'],
      'Day 7: Recovery and Flexibility': ['Full-body flexibility exercises (focus on hips, hamstrings, and shoulders)','Foam rolling for muscle recovery'],
    },
  };

  String _selectedLevel = 'Beginner';
  Map<String, bool> _completedDays = {};
  Map<String, int> _completedExercisesPerDay = {};

  @override
  void initState() {
    super.initState();
    // Initialize progress tracking
    for (var level in _weeklyTrainingPlan.keys) {
      for (var day in _weeklyTrainingPlan[level]!.keys) {
        _completedDays[day] = false;
        _completedExercisesPerDay[day] = 0;
      }
    }
  }

  // Calculate global progress
  double get globalProgress {
    int completedDaysCount = _completedDays.values.where((completed) => completed).length;
    int totalDays = _weeklyTrainingPlan[_selectedLevel]!.keys.length;
    return completedDaysCount / totalDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.role} Training Plan'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Global Progress Indicator
            Text(
              'Global Progress:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: globalProgress,
              minHeight: 8,
              color: Colors.green,
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(height: 24),

            Text(
              'Select Training Level:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedLevel,
              isExpanded: true,
              items: _weeklyTrainingPlan.keys
                  .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLevel = value!;
                  _resetProgress();
                });
              },
            ),
            SizedBox(height: 24),
            Text(
              'Training Plan for $_selectedLevel:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _weeklyTrainingPlan[_selectedLevel]!.keys.length,
                itemBuilder: (context, index) {
                  String day = _weeklyTrainingPlan[_selectedLevel]!.keys.elementAt(index);
                  List<String> exercises = _weeklyTrainingPlan[_selectedLevel]![day]!;
                  bool isDayUnlocked = index == 0 || (_completedDays[_weeklyTrainingPlan[_selectedLevel]!.keys.elementAt(index - 1)] ?? false);
                  int completedExercises = _completedExercisesPerDay[day] ?? 0;

                  // If day is not unlocked, hide the ExpansionTile
                  if (!isDayUnlocked && index != 0) {
                    return Container(); // This will hide the upcoming days.
                  }

                  return Card(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: custom_badges.Badge(
                      badgeContent: _completedDays[day]!
                          ? Text('Done', style: TextStyle(color: Colors.white))
                          : Text('Locked', style: TextStyle(color: Colors.white)),
                      badgeStyle: custom_badges.BadgeStyle(
                        badgeColor: _completedDays[day]! ? Colors.green : Colors.red,
                      ),
                      position: custom_badges.BadgePosition.topEnd(top: -10, end: -10),
                      child: ExpansionTile(
                        leading: Icon(Icons.calendar_today, color: isDayUnlocked ? Colors.blueAccent : Colors.grey),
                        title: Text(
                          day,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDayUnlocked ? Colors.black : Colors.grey,
                          ),
                        ),
                        subtitle: LinearProgressIndicator(
                          value: exercises.isEmpty ? 1 : completedExercises / exercises.length,
                          color: _completedDays[day]! ? Colors.green : Colors.orange,
                          backgroundColor: Colors.grey[300],
                        ),
                        // Disable ExpansionTile if the day is locked
                        onExpansionChanged: (expanded) {
                          if (!isDayUnlocked) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Complete today's exercises to unlock the next day")),
                            );
                          }
                        },
                        children: exercises.map((exercise) {
                          return CheckboxListTile(
                            value: _completedExercisesPerDay[day]! >= exercises.indexOf(exercise) + 1,
                            onChanged: isDayUnlocked
                                ? (value) {
                              setState(() {
                                if (value!) {
                                  _completedExercisesPerDay[day] = (completedExercises + 1).clamp(0, exercises.length);
                                } else {
                                  _completedExercisesPerDay[day] = (completedExercises - 1).clamp(0, exercises.length);
                                }

                                // Mark day as completed if all exercises are done
                                if (_completedExercisesPerDay[day] == exercises.length) {
                                  _completedDays[day] = true;
                                } else {
                                  _completedDays[day] = false;
                                }
                              });
                            }
                                : null,
                            title: Text(
                              exercise,
                              style: TextStyle(color: isDayUnlocked ? Colors.black : Colors.grey),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetProgress() {
    for (var day in _weeklyTrainingPlan[_selectedLevel]!.keys) {
      _completedDays[day] = false;
      _completedExercisesPerDay[day] = 0;
    }
  }
}