import 'package:flutter/widgets.dart';

class StudentName extends StatelessWidget {
  final String name;
  const StudentName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name, style: const TextStyle(fontSize: 20));
  }
}
