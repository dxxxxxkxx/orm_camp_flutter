class Person {
  static int currentIndex = 0;
  final int index;
  final String? photoSrc;
  final String name;
  final String? phoneNum;
  final String? email;
  final String? instagram;

  Person({
    this.photoSrc,
    required this.name,
    this.phoneNum,
    this.email,
    this.instagram,
  }) : index = Person.currentIndex++;
}
