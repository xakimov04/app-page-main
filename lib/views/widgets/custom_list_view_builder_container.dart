import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/views/screens/course_info_screen/course_info_screen.dart';

class CustomListViewBuilderContainer extends StatelessWidget {
  final bool isViewStylePressed;
  final Course course;
  final bool isDelete;
  final Function()? onDeletePressed;

  const CustomListViewBuilderContainer({
    super.key,
    required this.course,
    required this.isViewStylePressed,
    required this.isDelete,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => CourseInfoScreen(course: course),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xff041955),
            borderRadius: BorderRadius.circular(25),
          ),
          child: isViewStylePressed
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 150,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Image.network(
                        course.courseImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Course name:\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: course.courseTitle,
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Gap(15),
                          Text(
                            'Description:  ${course.courseDescription.split(' ')[0]}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${course.coursePrice.toString()} \$',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Course name: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: course.courseTitle,
                                    style: TextStyle(
                                      color: Colors.grey[200],
                                    ),
                                  )
                                ]),
                              ),
                              Text(
                                course.courseDescription.split(' ')[0],
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                              // left: 50,
                            ),
                            child: Text(
                              '${course.coursePrice.toString()} \$',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (isDelete)
                      TextButton(
                          onPressed: onDeletePressed,
                          child: const Text('Delete course')),
                  ],
                ),
        ),
      ),
    );
  }
}
