import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final int currentStreak;
  final int currentXp;
  final int currentLives;

  const Profile({
    super.key,
    required this.currentStreak,
    required this.currentXp,
    required this.currentLives,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'), // Changed title for clarity
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
        elevation: 0, // Keep it flat
      ),
      body: Center( // Center the entire content block for desktop
        child: ConstrainedBox( // Constrain max width for better readability on very wide screens
          constraints: const BoxConstraints(maxWidth: 800), // Max width for content
          child: SingleChildScrollView( // Allow scrolling if content overflows (e.g., on smaller desktop windows)
            padding: const EdgeInsets.all(40.0), // More generous padding for desktop
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                // Larger Avatar
                const CircleAvatar(
                  radius: 80, // Increased size for desktop
                  backgroundColor: Colors.blueGrey, // Changed color for visual interest
                  child: Icon(Icons.person_outline, size: 100, color: Colors.white), // Outlined icon for a modern look
                ),
                const SizedBox(height: 30),

                const Text(
                  'Your Progress Overview', // More descriptive title
                  style: TextStyle(
                    fontSize: 32, // Larger font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Keep learning and growing with Native...',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Stats Section: Using a Row with Cards for better desktop layout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
                  children: [
                    _buildStatCard('🔥 Streak', currentStreak.toString(), Colors.redAccent),
                    _buildStatCard('✨ XP', currentXp.toString(), Colors.amber),
                    _buildStatCard('❤️ Lives', currentLives.toString(), Colors.blue),
                  ],
                ),
                const SizedBox(height: 40),

                // Placeholder for Achievements/Badges
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Achievements',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        // Example achievement icons (replace with actual logic later)
                        Wrap( // Use Wrap for flexible icon layout
                          spacing: 20, // Horizontal space between icons
                          runSpacing: 20, // Vertical space between rows of icons
                          children: const [
                            Icon(Icons.emoji_events, size: 50, color: Colors.amber),
                            Icon(Icons.military_tech, size: 50, color: Colors.blue),
                            Icon(Icons.psychology, size: 50, color: Colors.green),
                            Icon(Icons.diamond, size: 50, color: Colors.purple),
                            // Add more achievement icons/widgets
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your journey is just beginning. Keep practicing daily to earn more XP and unlock new achievements!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // New helper widget for individual stat cards
  Widget _buildStatCard(String label, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 180, // Fixed width for consistent card size
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.circle, size: 40, color: color.withOpacity(0.8)), // Visually appealing icon
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}