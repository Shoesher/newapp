import 'package:flutter/material.dart';
import 'package:newapp/pages/profile.dart';
import 'package:newapp/pages/settings.dart';
import 'package:newapp/pages/shop.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Native',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
        elevation: 0, //Removes shadow under the app bar
        //App bar icons
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Shop()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User dashboard
              _buildStatsCard(),
              const SizedBox(height: 20),

              //Topics
              _buildTopicSection('Fundamentals', [
                _buildTopicTile(
                    context, 'Greetings', Icons.waving_hand, Colors.blueAccent),
                _buildTopicTile(
                    context, 'Numbers', Icons.format_list_numbered, Colors.green),
                _buildTopicTile(
                    context, 'Common Phrases', Icons.chat_bubble, Colors.orange),
              ]),
              const SizedBox(height: 20),

              _buildTopicSection('Everyday Life', [
                _buildTopicTile(
                    context, 'Family', Icons.family_restroom, Colors.purple),
                _buildTopicTile(
                    context, 'Food', Icons.fastfood, Colors.redAccent),
                _buildTopicTile(
                    context, 'Animals', Icons.pets, Colors.brown),
              ]),
              const SizedBox(height: 20),

              _buildTopicSection('Culture & Nature', [
                _buildTopicTile(
                    context, 'Nature', Icons.landscape, Colors.lightGreen),
                _buildTopicTile(
                    context, 'Traditions', Icons.star, Colors.indigo),
              ]),
            ],
          ),
        ),
      ),
      // Removed bottomNavigationBar since the items are now in the AppBar
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.local_fire_department, color: Colors.red, size: 30),
                const SizedBox(height: 5),
                const Text(
                  '2', //streak value
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text('Streak', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 30),
                const SizedBox(height: 5),
                const Text(
                  '1250', //XP Value
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text('XP', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.bolt, color: Colors.blue, size: 30),
                const SizedBox(height: 5),
                const Text(
                  '5', //Lives Value
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text('Lives', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(children: tiles),
      ],
    );
  }

  Widget _buildTopicTile(
      BuildContext context, String topicName, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          print('$topicName tapped');
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  topicName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}