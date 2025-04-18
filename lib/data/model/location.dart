class Location {
  String title;
  String link;
  String category;
  String roadAddress;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.roadAddress,
  });

  ///1. fromJson 네임드 생성자 만들기
  Location.fromJson(Map<String, dynamic> map)
    : this(
        title: map['title'],
        link: map['link'],
        category: map['category'],
        roadAddress: map['roadAddress'],
      );

  //2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'category': category,
      'roadAddress': roadAddress,
    };
  }
}
