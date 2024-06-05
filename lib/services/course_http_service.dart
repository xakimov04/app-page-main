import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/models/lesson_model.dart';

class CourseHttpService {
  Future<List<Course>> getData() async {
    final Uri url = Uri.parse(
      'https://course-2760d-default-rtdb.firebaseio.com/.json',
    );

    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      List<Course> loadedCourses = [];
      data.forEach(
        (String key, dynamic value) {
          value['id'] = key;
          loadedCourses.add(Course.fromJson(value));
        },
      );
      return loadedCourses;
    }
    throw Exception('Error: CourseHttpService().getData()');
  }

  Future<Course> addCourse({
    required String courseTitle,
    required String courseDescription,
    required String courseImageUrl,
    required List<Lesson> courseLessons,
    required num coursePrice,
  }) async {
    Map<String, dynamic> courseData = {
      'course-title': courseTitle,
      'course-description': courseDescription,
      'course-image': courseImageUrl,
      'course-lessons': courseLessons.map((lesson) => lesson.toJson()).toList(),
      'course-price': coursePrice,
    };
    final Uri url = Uri.parse(
      'https://lesson46-c2288-default-rtdb.firebaseio.com/.json',
    );
    final http.Response response = await http.post(
      url,
      body: jsonEncode(courseData),
    );
    final data = jsonDecode(response.body);
    courseData['id'] = data['name'];
    return Course.fromJson(courseData);
  }

  Future<void> deleteCourse({required String id}) async {
    final Uri url = Uri.parse(
      'https://lesson46-c2288-default-rtdb.firebaseio.com/$id.json',
    );
    await http.delete(url);
  }
}
