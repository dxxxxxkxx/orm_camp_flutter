import 'package:flutter/material.dart';

import 'contacts.dart';
import 'person.dart';
import 'profile.dart';

class BusinessCardScreen extends StatelessWidget {
  final Person person;

  BusinessCardScreen({super.key})
      : person = Person(
            photoSrc:
                'https://search.pstatic.net/common?type=b&size=3000&quality=100&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2Fportrait%2F202002%2F20200228151453288.jpg',
            name: '손예진',
            phoneNum: '010-0000-0000',
            email: 'sonyejin@msteam.co.kr',
            instagram: '@yejinhand');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 7, child: Profile(person: person)),
            Expanded(flex: 3, child: Contacts(person: person))
          ],
        ),
      ),
    );
  }
}
