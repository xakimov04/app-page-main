import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/viewmodels/course_view_model.dart';
import 'package:settings_page/viewmodels/todo_view_model.dart';
import 'package:settings_page/views/screens/todo_screen/todo_screen.dart';
import 'package:settings_page/views/widgets/custom_inkwell_button.dart';
import 'package:settings_page/views/widgets/custom_list_view_builder_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CourseViewModel _courseViewModel = CourseViewModel();
  bool _isViewStylePressed = false;
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
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "What`s Up, Mardon!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "CATEGORIES",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff86A3EF)),
            ),
          ),
          const Gap(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Gap(20),
                CustomInkwellButton(
                  nextPage: const TodoScreen(),
                  buttonText: 'Todos',
                  tasks: doneTodo + unDoneTodo,
                ),
                const Gap(15),
                CustomInkwellButton(
                  nextPage: Scaffold(
                    appBar: AppBar(),
                  ),
                  buttonText: 'Notes',
                  tasks: doneTodo + unDoneTodo,
                ),
                const Gap(20),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () =>
                    setState(() => _isViewStylePressed = !_isViewStylePressed),
                child: const Text(
                  'Change view style',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff86A3EF),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: _courseViewModel.courseList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff041955),
                    ),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Center(child: Text('error: ${snapshot.error}'));
                } else {
                  List<Course> courseList = snapshot.data;
                  return _isViewStylePressed
                      ? GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: courseList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: .55,
                          ),
                          itemBuilder: (context, index) =>
                              CustomListViewBuilderContainer(
                            isViewStylePressed: _isViewStylePressed,
                            course: courseList[index],
                            isDelete: false,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: courseList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CustomListViewBuilderContainer(
                            isViewStylePressed: _isViewStylePressed,
                            course: courseList[index],
                            isDelete: false,
                          ),
                        );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
