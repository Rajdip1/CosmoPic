class APIModel {
  late final String title;
  late final String date;
  late final String description;
  late final String imgUrl;

  APIModel({required this.title, required this.date, required this.description, required this.imgUrl});

  factory APIModel.fromJson(Map<String, dynamic> json) {
    return APIModel(
        title: json['title'] ?? 'No Title',
        date: json['date'] ?? 'No Date',
        description: json['explanation'] ?? 'No Description',
        imgUrl: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'explanation': description,
      'url': imgUrl
    };
  }
}