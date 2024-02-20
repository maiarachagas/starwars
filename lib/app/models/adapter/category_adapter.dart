import 'package:hive/hive.dart';

import '../category_model.dart';

part 'category_adapter.g.dart';

@HiveType(typeId: 0)
class CategoryAdapter extends HiveObject {
  @HiveField(0)
  int? count;

  @HiveField(1)
  String? next;

  @HiveField(2)
  String? current;

  @HiveField(3)
  String? previous;

  @HiveField(4)
  String? name;

  @HiveField(5)
  List<DetailAdapter>? detail;

  CategoryAdapter(
      {this.count,
      this.next,
      this.current,
      this.previous,
      this.name,
      this.detail});

  factory CategoryAdapter.fromCategory(Category category, String name) {
    return CategoryAdapter()
      ..count = category.count
      ..next = category.next
      ..current = category.current
      ..previous = category.previous
      ..name = name
      ..detail = category.detail
          ?.map((detail) => DetailAdapter.fromDetail(detail))
          .toList();
  }

  Category toCategory() {
    return Category(
      count: count,
      next: next,
      current: current,
      previous: previous,
      name: name,
      detail: detail?.map((detail) => detail.toDetail()).toList(),
    );
  }

  @override
  String toString() {
    return 'CategoryAdapter(name: $name, count: $count, next: $next, current: $current, previous: $previous, detail: $detail)';
  }
}

@HiveType(typeId: 1)
class DetailAdapter extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? image;

  DetailAdapter({
    this.name,
    this.image,
  });

  factory DetailAdapter.fromDetail(Detail detail) {
    return DetailAdapter()
      ..name = detail.name
      ..image = detail.image;
  }

  Detail toDetail() {
    return Detail(
      name: name,
      image: image,
    );
  }

  @override
  String toString() => 'DetailAdapter(name: $name, image: $image)';
}
