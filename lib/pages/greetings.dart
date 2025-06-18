// lib/pages/greetings_page.dart
import 'package:flutter/material.dart';
import 'package:newapp/pages/lesson.dart'; // Import Lesson model
import 'package:newapp/pages/lesson_page.dart'; // Import LessonPage

class Greetings extends StatefulWidget {
  const Greetings({super.key});

  @override
  State<Greetings> createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<Greetings> {
  // Define your greetings lessons here using the Lesson model
  final List<Lesson> _greetingsLessons = [
    Lesson(
      id: 1,
      title: 'Basic Hellos',
      description: 'Learn how to say hello and goodbye in Cree.',
      icon: Icons.waving_hand,
      iconColor: Colors.blueAccent,
      isCompleted: false, // You can manage this state (e.g., from SharedPreferences)
    ),
    Lesson(
      id: 2,
      title: 'Introductions',
      description: 'Introduce yourself and ask others their names.',
      icon: Icons.person_add,
      iconColor: Colors.green,
      isCompleted: false,
    ),
    Lesson(
      id: 3,
      title: 'Common Phrases',
      description: 'Practice phrases like "How are you?" and "I am well."',
      icon: Icons.chat_bubble,
      iconColor: Colors.orange,
      isCompleted: false,
      // isLocked: true, // Uncomment this to test a locked lesson
    ),
    Lesson(
      id: 4,
      title: 'Cultural Greetings',
      description: 'Understand traditional greetings and their significance.',
      icon: Icons.diversity_3,
      iconColor: Colors.purple,
      isCompleted: false,
    ),
    Lesson(
      id: 5,
      title: 'Farewells',
      description: 'Learn various ways to say goodbye and pleasant departures.',
      icon: Icons.exit_to_app,
      iconColor: Colors.teal,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings Lessons'), // Updated title
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800), // Max width for desktop
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            itemCount: _greetingsLessons.length,
            itemBuilder: (context, index) {
              final lesson = _greetingsLessons[index];
              // Pass isLast to the node builder to determine if the line should continue
              return _buildLessonNode(context, lesson, index == _greetingsLessons.length - 1);
            },
          ),
        ),
      ),
    );
  }

  // Helper widget to build each lesson node and its corresponding timeline segment
  Widget _buildLessonNode(BuildContext context, Lesson lesson, bool isLast) {
    return IntrinsicHeight( // Ensures the Row children take up the height of the tallest child
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to fill vertical space
        children: [
          // Timeline Column (left side)
          Column(
            children: [
              // Node Circle
              _buildTimelineNode(lesson.id, lesson.isCompleted, lesson.isLocked),
              // Vertical Line (only if it's not the last node)
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 4.0, // Thickness of the line
                    color: lesson.isCompleted ? Colors.grey[700] : Colors.grey[400], // Darker if completed
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20), // Space between timeline and lesson tile

          // Lesson Tile (right side)
          Expanded( // Takes up the remaining horizontal space
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0), // Vertical spacing between cards
              child: Opacity( // Dim the card visually if locked
                opacity: lesson.isLocked ? 0.6 : 1.0,
                child: Card(
                  elevation: lesson.isLocked ? 0 : 4, // No shadow for locked lessons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: lesson.isLocked ? BorderSide(color: Colors.grey[300]!) : BorderSide.none,
                  ),
                  child: InkWell(
                    // onTap logic: checks if the lesson is locked
                    onTap: lesson.isLocked
                        ? () {
                            // Show a message if lesson is locked
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Complete previous lessons to unlock this one!'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        : () {
                            // Navigate to LessonPage, passing the full Lesson object
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonPage(lesson: lesson),
                              ),
                            );
                          },
                    borderRadius: BorderRadius.circular(15), // Match Card's border radius
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), // Generous padding for desktop
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30, // Larger avatar for desktop
                            backgroundColor: lesson.iconColor.withOpacity(0.15),
                            child: Icon(lesson.icon, size: 35, color: lesson.iconColor), // Larger icon
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
                              children: [
                                Text(
                                  'Lesson ${lesson.id}',
                                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  lesson.title,
                                  style: const TextStyle(
                                    fontSize: 22, // Larger title
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  lesson.description,
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                  maxLines: 2, // Allow description to wrap
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // Visual indicators for completion/locked status
                          if (lesson.isCompleted)
                            const Icon(Icons.check_circle, color: Colors.green, size: 30)
                          else if (lesson.isLocked)
                            const Icon(Icons.lock, color: Colors.grey, size: 30)
                          else
                            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the circular timeline node with the lesson number
  Widget _buildTimelineNode(int lessonId, bool isCompleted, bool isLocked) {
    return Container(
      width: 40, // Diameter of the node circle
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? Colors.green[700] // Darker green if completed
            : isLocked
                ? Colors.grey[300] // Lighter grey for locked
                : Colors.blueAccent, // Default color for active/unlocked
        border: Border.all(
          color: isCompleted ? Colors.green : Colors.blueGrey.withOpacity(0.5),
          width: 3.0,
        ),
      ),
      child: Center(
        child: Text(
          '$lessonId',
          style: TextStyle(
            color: isLocked ? Colors.grey[600] : Colors.white, // Text color changes based on lock status
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}