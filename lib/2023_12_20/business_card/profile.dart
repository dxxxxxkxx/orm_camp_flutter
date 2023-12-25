import 'package:flutter/material.dart';

import 'person.dart';

class Profile extends StatelessWidget {
  final Person person;

  const Profile({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160.0,
          child: person.photoSrc != null
              ? Image.network(person.photoSrc!, fit: BoxFit.cover)
              : const Icon(Icons.person),
        ),
        const SizedBox(height: 8.0),
        Text(
          person.name,
          style: const TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
