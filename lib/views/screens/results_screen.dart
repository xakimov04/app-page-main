import 'package:flutter/material.dart';
import 'package:settings_page/viewmodels/todo_view_model.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final TodoViewModel _todoViewModel = TodoViewModel();

  int doneTodo = 0;
  int unDoneTodo = 0;

  @override
  void initState() {
    super.initState();
    _todoViewModel.countDoneTodo().then(
      (value) {
        doneTodo = value['done'] ?? 0;
        unDoneTodo = value['undone'] ?? 0;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResultCard(
              count: doneTodo,
              label: 'Done todos',
              color: Colors.green,
              icon: Icons.check_circle_outline,
            ),
            const SizedBox(height: 50),
            ResultCard(
              count: unDoneTodo,
              label: 'Undone todos',
              color: Colors.red,
              icon: Icons.cancel_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  final IconData icon;

  const ResultCard({
    super.key,
    required this.count,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff041955),
      elevation: 5,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$count',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
