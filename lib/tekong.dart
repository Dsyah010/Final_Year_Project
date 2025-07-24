import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as custom_badges;

class Tekong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TrainingPage(role: "Tekong");
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
      'Day 1: Basic Coordination and Balance': ['Warm-Up: 10 minutes jogging + dynamic stretching','Ladder drills: 3 sets x 5 variations (e.g., single steps, lateral steps)','Standing ball toss and catch: 10 minutes (focus on accuracy)','Single-leg balance holds: 3 x 15 seconds per leg','Cool Down: Static stretching (hamstrings, quads, and calves)'],
      'Day 2: Core Strength':['Warm-Up: Jump rope for 5 minutes','Plank holds: 3 x 20 seconds','Dead bugs: 3 x 12 reps','Bird dogs: 3 x 10 reps per side','Cool Down: Deep breathing and core-focused stretching'],
      'Day 3: Leg Strength':['Warm-Up: Brisk walking for 5 minutes','Bodyweight squats: 3 x 12 reps','Wall sits: 3 x 20 seconds','Step-ups on a low bench: 3 x 10 per leg','Cool Down: Stretching hamstrings and calves'],
      'Day 4: Rest/Active Recovery':['Light walking or swimming for 20-30 minutes'],
      'Day 5: Flexibility':['Warm-Up: Light jogging for 5 minutes','Forward lunges with twist: 3 x 8 reps per side','Seated forward fold: Hold for 30 seconds, 3 sets','Butterfly stretch: Hold for 30 seconds, 3 sets','Cool Down: Deep breathing exercises'],
      'Day 6: Ball Contact and Control':['Warm-Up: Jogging in place for 5 minutes','Low toss ball juggling: 10 minutes (focus on controlling the ball with feet and thighs)','Target serving: Practice aiming at a marked spot 5 meters away (10 sets x 5 serves)','Cool Down: Stretch and relax'],
      'Day 7: Reaction and Recovery':['Reaction drills: Partner drops ball; Tekong reacts to catch or kick (3 sets x 10 reps)','Foam rolling for muscle recovery'],

    },
    'Intermediate': {
      'Day 1: Agility and Balance': ['Warm-Up: 10 minutes jogging + dynamic stretching','Ladder drills: 3 x 5 variations (e.g., lateral hops, quick steps)','Cone drills (zigzag runs): 5 x 10 meters','Single-leg ball toss and kick: 3 x 10 reps per leg','Cool Down: Stretching'],
      'Day 2: Core and Stability': ['Warm-Up: Jump rope for 5 minutes','Side planks with leg lift: 3 x 10 seconds per side','Russian twists: 3 x 15 reps (use light weight if available)','Stability ball rollouts: 3 x 12 reps','Cool Down: Core-focused stretches'],
      'Day 3: Power Training': ['Warm-Up: Jogging + leg swings for 5 minutes','Weighted squats (lightweights): 3 x 10 reps','Calf raises (on elevated surface): 3 x 15 reps','Broad jumps: 3 x 10 reps','Cool Down: Stretching glutes and hip flexors'],
      'Day 4: Rest/Active Recovery': ['Swimming or cycling for 20-30 minutes'],
      'Day 5: Serving Accuracy': ['Warm-Up: 5 minutes jogging + dynamic stretching','High ball toss and spike serve: 5 x 10 reps','Target serving: 10 sets of 5 serves aiming at specific quadrants','Ball control drills: 10 minutes','Cool Down: Stretching and relaxation'],
      'Day 6: Combination Drills': ['Warm-Up: 10 minutes jogging + stretching','Ladder drills into serving practice: 3 x 10 sets','Cone drills into single-leg balance kicks: 3 x 12 reps','Cool Down: Deep breathing and stretching'],
      'Day 7: Flexibility and Recovery': ['Full-body stretching routine','Foam rolling and light yoga for muscle recovery'],

    },
    'Advanced': {
      'Day 1: Advanced Agility': ['Warm-Up: High-knee jogging for 5 minutes','Ladder drills: 4 x 5 advanced variations (e.g., cross steps, in-and-out hops)','Sprint intervals: 6 x 20 meters','Single-leg hops over cones: 3 x 20 seconds per leg','Cool Down: Stretching'],
      'Day 2: Explosive Core': ['Warm-Up: Jump rope with speed changes for 5 minutes','Medicine ball slams: 3 x 12 reps','Hanging leg raises: 3 x 12 reps','Plank-to-push-up transitions: 3 x 12 reps','Cool Down: Core stretches'],
      'Day 3: Leg Power': ['Warm-Up: Jogging and dynamic stretching','Depth jumps: 3 x 12 reps','Explosive box jumps: 3 x 10 reps','Single-leg Bulgarian split squats: 3 x 10 reps per leg','Cool Down: Focus on hamstrings and hip flexors'],
      'Day 4: Active Recovery': ['Light swimming or yoga session'],
      'Day 5: Precision Serving': ['Warm-Up: 5 minutes jump rope + dynamic stretches','Target serving: 10 sets x 10 serves (vary distances and angles)','Partner serve-and-return practice: 5 sets of 10 reps','Cool Down: Stretching and foam rolling'],
      'Day 6: High-Intensity Circuit': ['Warm-Up: 10 minutes jogging + stretching','Lateral cone hops: 30 seconds (3 rounds)','Jump squats: 12 reps (3 rounds)','Ball juggling: 1 minute (3 rounds)','Shuttle runs: 30 seconds (3 rounds)','Cool Down: Stretch and relax'],
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