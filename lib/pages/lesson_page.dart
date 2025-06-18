// lib/pages/lesson_page.dart
import 'package:flutter/material.dart';
import 'package:newapp/pages/greetings.dart';
import 'package:newapp/pages/lesson.dart'; // Import the Lesson model

class LessonPage extends StatefulWidget { // Changed to StatefulWidget
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  // Simple lesson content for demonstration.
  // In a real app, this would be loaded dynamically based on widget.lesson.id
  // and would likely involve a list of structured exercise objects.
  final List<Map<String, String>> _exercises = [
    {
      'question': 'How do you say "Hello" in Cree (Plains Cree, assuming a common dialect)?',
      'correctAnswer': 'Tansi',
      'example': 'Tansi, kiya? (Hello, how are you?)',
    },
    {
      'question': 'How do you say "Goodbye" in Cree?',
      'correctAnswer': 'Miyosin', // Or 'Tawâw' (come in/welcome) for general departure
      'example': 'Miyosin! Kakiyaw kâwâpahtinân. (Goodbye! See you all.)',
    },
    {
      'question': 'What does "êkosi" mean?',
      'correctAnswer': 'That\'s all / The end',
      'example': 'Êkosi, nîstan. (That\'s all for me too.)',
    },
  ];

  int _currentExerciseIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.transparent;

  void _checkAnswer() {
    String userAnswer = _answerController.text.trim();
    String correctAnswer = _exercises[_currentExerciseIndex]['correctAnswer']!;

    if (userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
      setState(() {
        _feedbackMessage = 'Correct! Good job!';
        _feedbackColor = Colors.green;
      });
    } else {
      setState(() {
        _feedbackMessage = 'Incorrect. Try again!';
        _feedbackColor = Colors.red;
      });
    }
    // Clear the input after checking
    _answerController.clear();
  }

  void _nextExercise() {
    setState(() {
      _feedbackMessage = ''; // Clear feedback for next exercise
      if (_currentExerciseIndex < _exercises.length - 1) {
        _currentExerciseIndex++;
      } else {
        // All exercises completed
        _feedbackMessage = 'Lesson Completed!';
        _feedbackColor = Colors.blue;
        // Optionally, navigate back or show a completion screen
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context); // Go back to Greetings page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lesson ${widget.lesson.id}: "${widget.lesson.title}" completed!'),
              backgroundColor: Colors.blue,
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if all exercises are completed
    bool lessonFinished = _currentExerciseIndex >= _exercises.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson ${widget.lesson.id}: ${widget.lesson.title}'),
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox( // Limit content width for desktop
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(30.0), // More generous padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lesson Header
                Icon(widget.lesson.icon, size: 80, color: widget.lesson.iconColor),
                const SizedBox(height: 20),
                Text(
                  widget.lesson.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.lesson.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // Lesson Content / Exercise Area
                if (!lessonFinished)
                  Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _exercises[_currentExerciseIndex]['question']!,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Example: "${_exercises[_currentExerciseIndex]['example']!}"',
                                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _answerController,
                                decoration: InputDecoration(
                                  labelText: 'Your Answer',
                                  hintText: 'Type here...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blueGrey[50],
                                ),
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                onSubmitted: (value) => _checkAnswer(), // Allow enter to submit
                              ),
                              const SizedBox(height: 15),
                              Text(
                                _feedbackMessage,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _feedbackColor),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Check Answer'),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: _nextExercise,
                        child: Text(
                          _currentExerciseIndex < _exercises.length - 1 ? 'Submit Awnser' : 'Finish Lesson',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      const Icon(Icons.celebration, size: 100, color: Colors.green),
                      const SizedBox(height: 20),
                      Text(
                        _feedbackMessage,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _feedbackColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Greetings()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Back to Lessons'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}