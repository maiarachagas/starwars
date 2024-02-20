import 'dart:convert';

class Category {
  int? count;
  String? next;
  String? current;
  String? previous;
  String? name;
  List<Detail>? detail;

  Category({
    this.count,
    this.next,
    this.current,
    this.previous,
    this.name,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'current': current,
      'previous': previous,
      'name': name,
      'detail': detail?.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(
      Map<String, dynamic> map, String url, String category) {
    return Category(
      count: map['count']?.toInt(),
      next: map['next'],
      current: url,
      previous: map['previous'] ?? 'page=0',
      name: map['name'] ?? '',
      detail: map['results'] != null
          ? List<Detail>.from(map['results']?.map((x) => Detail.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source, String url, String category) =>
      Category.fromMap(json.decode(source), url, category);
}

class Detail {
  String? name;
  String? image;

  Detail({
    this.name,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory Detail.fromMap(Map<String, dynamic> map) {
    return Detail(
      name: map['name'] ?? map['title'],
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Detail.fromJson(String source) => Detail.fromMap(json.decode(source));

  @override
  String toString() => 'Detail(name: $name, image: $image)';
}
