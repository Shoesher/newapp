import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopPageState();
}

class _ShopPageState extends State<Shop> {
  int _currentXp = 0;
  int _streakFreezes = 0;
  int _lives = 0;
  int _hints = 0;

  final int _streakFreezeCost = 100;
  final int _lifeCost = 50;
  final int _hintCost = 25;

  @override
  void initState() {
    super.initState();
    _loadShopData();
  }

  Future<void> _loadShopData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentXp = 1250;
      _streakFreezes = prefs.getInt('streakFreezes') ?? 0;
      _lives = prefs.getInt('lives') ?? 5; // Default lives
      _hints = prefs.getInt('hints') ?? 0;
    });
  }

  Future<void> _purchaseItem(String itemType, int cost) async {
    if (_currentXp >= cost) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _currentXp -= cost;
        prefs.setInt('xp', _currentXp); // Update XP in storage

        switch (itemType) {
          case 'streakFreeze':
            _streakFreezes++;
            prefs.setInt('streakFreezes', _streakFreezes);
            break;
          case 'life':
            _lives++;
            prefs.setInt('lives', _lives);
            break;
          case 'hint':
            _hints++;
            prefs.setInt('hints', _hints);
            break;
        }
      });
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully purchased $itemType!'),
          backgroundColor: Colors.green, // Green for success
          duration: const Duration(seconds: 2), // Short duration
        ),
      );
    } else {
      // Show insufficient XP message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough XP to purchase this item!'),
          backgroundColor: Colors.red, // Red for warning
          duration: Duration(seconds: 2), // Short duration
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Corrected PopScope usage:
    // When canPop is true, the default pop behavior will happen.
    // We only need to tell the Navigator to return a result when it does pop.
    // The onPopInvokedWithResult callback is for side effects *before* the pop,
    // or to block the pop. To return a result, it's typically done via the route itself,
    // or by overriding `didPop`.
    // The most straightforward way to return a result is in the route's `pop` method
    // (which we trigger from Homepage), or by using the `result` parameter
    // if we were blocking the pop and then manually popping.
    // For simplicity, let's ensure the `Navigator.pop` in `Homepage` handles the result.

    return Scaffold( // Removed PopScope here for now, as it might be interfering
      appBar: AppBar(
        title: const Text('Native Shop'),
        backgroundColor: const Color.fromARGB(255, 43, 255, 0),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    '$_currentXp XP',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enhance Your Learning Journey!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Spend your hard-earned XP to unlock powerful advantages.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 25.0,
                  runSpacing: 25.0,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildShopItem(
                      title: 'Streak Freeze',
                      description: 'Protects your streak for one day if you miss a lesson.',
                      cost: _streakFreezeCost,
                      icon: Icons.ac_unit,
                      iconColor: Colors.cyan,
                      onPurchase: () => _purchaseItem('streakFreeze', _streakFreezeCost),
                      currentCount: _streakFreezes,
                    ),
                    _buildShopItem(
                      title: 'Extra Life',
                      description: 'Gain an additional life, letting you make more mistakes.',
                      cost: _lifeCost,
                      icon: Icons.favorite,
                      iconColor: Colors.red,
                      onPurchase: () => _purchaseItem('life', _lifeCost),
                      currentCount: _lives,
                    ),
                    _buildShopItem(
                      title: 'Hint Pack',
                      description: 'Receive a batch of hints to use on tough questions.',
                      cost: _hintCost,
                      icon: Icons.lightbulb_outline,
                      iconColor: Colors.amber,
                      onPurchase: () => _purchaseItem('hint', _hintCost),
                      currentCount: _hints,
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

  // Same _buildShopItem as before
  Widget _buildShopItem({
    required String title,
    required String description,
    required int cost,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onPurchase,
    required int currentCount,
  }) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 280,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: iconColor.withOpacity(0.15),
                    child: Icon(icon, size: 32, color: iconColor),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                'You own: $currentCount',
                style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onPurchase,
                  icon: const Icon(Icons.star, size: 20, color: Colors.white),
                  label: Text(
                    '$cost XP',
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}