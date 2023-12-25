import 'package:flutter/material.dart';

import 'person.dart';

class Contacts extends StatelessWidget {
  final Person person;

  const Contacts({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (person.phoneNum != null)
          Text(person.phoneNum!, style: const TextStyle(fontSize: 24.0)),
        const SizedBox(height: 8.0),
        if (person.email != null)
          Text(person.email!, style: const TextStyle(fontSize: 24.0)),
        const SizedBox(height: 8.0),
        if (person.instagram != null)
          Text(person.instagram!, style: const TextStyle(fontSize: 24.0))
      ],
    );
  }
}
