import 'dart:convert';

class Planets {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Planet>? planet;

  Planets({
    this.count,
    this.next,
    this.current,
    this.previous,
    this.planet,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'current': current,
      'previous': previous,
      'results': planet?.map((x) => x.toMap()).toList(),
    };
  }

  factory Planets.fromMap(Map<String, dynamic> map, String url) {
    return Planets(
      count: map['count']?.toInt(),
      next: map['next'],
      current: map['current'],
      previous: map['previous'],
      planet: map['results'] != null
          ? List<Planet>.from(map['results']?.map((x) => Planet.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Planets.fromJson(String source, String url) =>
      Planets.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'Planets(count: $count, next: $next, current: $current, previous: $previous, results: $planet)';
  }
}

class Planet {
  String? name;
  String? rotationPeriod;
  String? orbitalPeriod;
  String? diameter;
  String? climate;
  String? gravity;
  String? terrain;
  String? surfaceWater;
  String? population;
  List<String>? residents;
  List<String>? films;
  String? created;
  String? edited;
  String? url;
  String? thumbnailUrl;

  Planet({
    this.name,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.diameter,
    this.climate,
    this.gravity,
    this.terrain,
    this.surfaceWater,
    this.population,
    this.residents,
    this.films,
    this.created,
    this.edited,
    this.url,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rotationPeriod': rotationPeriod,
      'orbitalPeriod': orbitalPeriod,
      'diameter': diameter,
      'climate': climate,
      'gravity': gravity,
      'terrain': terrain,
      'surfaceWater': surfaceWater,
      'population': population,
      'residents': residents,
      'films': films,
      'created': created,
      'edited': edited,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      name: map['name'],
      rotationPeriod: map['rotationPeriod'],
      orbitalPeriod: map['orbitalPeriod'],
      diameter: map['diameter'],
      climate: map['climate'],
      gravity: map['gravity'],
      terrain: map['terrain'],
      surfaceWater: map['surfaceWater'],
      population: map['population'],
      residents: List<String>.from(map['residents']),
      films: List<String>.from(map['films']),
      created: map['created'],
      edited: map['edited'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Planet.fromJson(String source) => Planet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Planet(name: $name, rotationPeriod: $rotationPeriod, orbitalPeriod: $orbitalPeriod, diameter: $diameter, climate: $climate, gravity: $gravity, terrain: $terrain, surfaceWater: $surfaceWater, population: $population, residents: $residents, films: $films, created: $created, edited: $edited, url: $url)';
  }
}
