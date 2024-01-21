import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/models/films_model.dart';

String get jsonBodyFilms => '''
   {
    "count": 6,
    "next": null,
    "previous": null,
    "results": [
         {
            "title": "A New Hope",
            "episode_id": 4,
            "opening_crawl": "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire.  During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the DEATH STAR, an armored space station with enough power to destroy an entire planet.  Pursued by the Empire's sinister agents, Princess Leia races home aboard her starship, custodian of the stolen plans that can save her people and restore freedom to the galaxy....",
            "director": "George Lucas",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1977-05-25",
            "characters": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/2/",
                "https://swapi.dev/api/people/3/",
                "https://swapi.dev/api/people/4/",
                "https://swapi.dev/api/people/5/",
                "https://swapi.dev/api/people/6/",
                "https://swapi.dev/api/people/7/",
                "https://swapi.dev/api/people/8/",
                "https://swapi.dev/api/people/9/",
                "https://swapi.dev/api/people/10/",
                "https://swapi.dev/api/people/12/",
                "https://swapi.dev/api/people/13/",
                "https://swapi.dev/api/people/14/",
                "https://swapi.dev/api/people/15/",
                "https://swapi.dev/api/people/16/",
                "https://swapi.dev/api/people/18/",
                "https://swapi.dev/api/people/19/",
                "https://swapi.dev/api/people/81/"
            ],
            "planets": [
                "https://swapi.dev/api/planets/1/",
                "https://swapi.dev/api/planets/2/",
                "https://swapi.dev/api/planets/3/"
            ],
            "starships": [
                "https://swapi.dev/api/starships/2/",
                "https://swapi.dev/api/starships/3/",
                "https://swapi.dev/api/starships/5/",
                "https://swapi.dev/api/starships/9/",
                "https://swapi.dev/api/starships/10/",
                "https://swapi.dev/api/starships/11/",
                "https://swapi.dev/api/starships/12/",
                "https://swapi.dev/api/starships/13/"
            ],
            "vehicles": [
                "https://swapi.dev/api/vehicles/4/",
                "https://swapi.dev/api/vehicles/6/",
                "https://swapi.dev/api/vehicles/7/",
                "https://swapi.dev/api/vehicles/8/"
            ],
            "species": [
                "https://swapi.dev/api/species/1/",
                "https://swapi.dev/api/species/2/",
                "https://swapi.dev/api/species/3/",
                "https://swapi.dev/api/species/4/",
                "https://swapi.dev/api/species/5/"
            ],
            "created": "2014-12-10T14:23:31.880000Z",
            "edited": "2014-12-20T19:49:45.256000Z",
            "url": "https://swapi.dev/api/films/1/"
        },
        {
            "title": "The Empire Strikes Back",
            "episode_id": 5,
            "opening_crawl": "It is a dark time for the Rebellion. Although the Death Star has been destroyed, Imperial troops have driven the Rebel forces from their hidden base and pursued them across the galaxy.  Evading the dreaded Imperial Starfleet, a group of freedom fighters led by Luke Skywalker has established a new secret base on the remote ice world of Hoth.  The evil lord Darth Vader, obsessed with finding young Skywalker, has dispatched thousands of remote probes into the far reaches of space....",
            "director": "Irvin Kershner",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1980-05-17",
            "characters": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/2/",
                "https://swapi.dev/api/people/3/",
                "https://swapi.dev/api/people/4/",
                "https://swapi.dev/api/people/5/",
                "https://swapi.dev/api/people/10/",
                "https://swapi.dev/api/people/13/",
                "https://swapi.dev/api/people/14/",
                "https://swapi.dev/api/people/18/",
                "https://swapi.dev/api/people/20/",
                "https://swapi.dev/api/people/21/",
                "https://swapi.dev/api/people/22/",
                "https://swapi.dev/api/people/23/",
                "https://swapi.dev/api/people/24/",
                "https://swapi.dev/api/people/25/",
                "https://swapi.dev/api/people/26/"
            ],
            "planets": [
                "https://swapi.dev/api/planets/4/",
                "https://swapi.dev/api/planets/5/",
                "https://swapi.dev/api/planets/6/",
                "https://swapi.dev/api/planets/27/"
            ],
            "starships": [
                "https://swapi.dev/api/starships/3/",
                "https://swapi.dev/api/starships/10/",
                "https://swapi.dev/api/starships/11/",
                "https://swapi.dev/api/starships/12/",
                "https://swapi.dev/api/starships/15/",
                "https://swapi.dev/api/starships/17/",
                "https://swapi.dev/api/starships/21/",
                "https://swapi.dev/api/starships/22/",
                "https://swapi.dev/api/starships/23/"
            ],
            "vehicles": [
                "https://swapi.dev/api/vehicles/8/",
                "https://swapi.dev/api/vehicles/14/",
                "https://swapi.dev/api/vehicles/16/",
                "https://swapi.dev/api/vehicles/18/",
                "https://swapi.dev/api/vehicles/19/",
                "https://swapi.dev/api/vehicles/20/"
            ],
            "species": [
                "https://swapi.dev/api/species/1/",
                "https://swapi.dev/api/species/2/",
                "https://swapi.dev/api/species/3/",
                "https://swapi.dev/api/species/6/",
                "https://swapi.dev/api/species/7/"
            ],
            "created": "2014-12-12T11:26:24.656000Z",
            "edited": "2014-12-15T13:07:53.386000Z",
            "url": "https://swapi.dev/api/films/2/"
        }
      ]
    }''';

String get jsonBodyFilmsByTitle => '''
  {
    "count": 1,
    "next": null,
    "previous": null,
    "results": [
        {
            "title": "The Empire Strikes Back",
            "episode_id": 5,
            "opening_crawl": "It is a dark time for the Rebellion. Although the Death Star has been destroyed, Imperial troops have driven the Rebel forces from their hidden base and pursued them across the galaxy.  Evading the dreaded Imperial Starfleet, a group of freedom fighters led by Luke Skywalker has established a new secret base on the remote ice world of Hoth.  The evil lord Darth Vader, obsessed with finding young Skywalker, has dispatched thousands of remote probes into the far reaches of space....",
            "director": "Irvin Kershner",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1980-05-17",
            "characters": [
                "https://swapi.dev/api/people/1/",
                "https://swapi.dev/api/people/2/",
                "https://swapi.dev/api/people/3/",
                "https://swapi.dev/api/people/4/",
                "https://swapi.dev/api/people/5/",
                "https://swapi.dev/api/people/10/",
                "https://swapi.dev/api/people/13/",
                "https://swapi.dev/api/people/14/",
                "https://swapi.dev/api/people/18/",
                "https://swapi.dev/api/people/20/",
                "https://swapi.dev/api/people/21/",
                "https://swapi.dev/api/people/22/",
                "https://swapi.dev/api/people/23/",
                "https://swapi.dev/api/people/24/",
                "https://swapi.dev/api/people/25/",
                "https://swapi.dev/api/people/26/"
            ],
            "planets": [
                "https://swapi.dev/api/planets/4/",
                "https://swapi.dev/api/planets/5/",
                "https://swapi.dev/api/planets/6/",
                "https://swapi.dev/api/planets/27/"
            ],
            "starships": [
                "https://swapi.dev/api/starships/3/",
                "https://swapi.dev/api/starships/10/",
                "https://swapi.dev/api/starships/11/",
                "https://swapi.dev/api/starships/12/",
                "https://swapi.dev/api/starships/15/",
                "https://swapi.dev/api/starships/17/",
                "https://swapi.dev/api/starships/21/",
                "https://swapi.dev/api/starships/22/",
                "https://swapi.dev/api/starships/23/"
            ],
            "vehicles": [
                "https://swapi.dev/api/vehicles/8/",
                "https://swapi.dev/api/vehicles/14/",
                "https://swapi.dev/api/vehicles/16/",
                "https://swapi.dev/api/vehicles/18/",
                "https://swapi.dev/api/vehicles/19/",
                "https://swapi.dev/api/vehicles/20/"
            ],
            "species": [
                "https://swapi.dev/api/species/1/",
                "https://swapi.dev/api/species/2/",
                "https://swapi.dev/api/species/3/",
                "https://swapi.dev/api/species/6/",
                "https://swapi.dev/api/species/7/"
            ],
            "created": "2014-12-12T11:26:24.656000Z",
            "edited": "2014-12-15T13:07:53.386000Z",
            "url": "https://swapi.dev/api/films/2/"
        }
    ]
}''';

List<Film> get film => [
      Film(title: 'A New Hope'),
      Film(title: 'Return of the Jedi'),
      Film(title: 'The Phantom Menace'),
    ];

List<InfoImage> get infoImage => [
      InfoImage(
          thumbnailUrl:
              'https://tse4.mm.bing.net/th?id=OIP.FKsBijrcaeAWzHQbO81nGQHaLI&pid=Api'),
      InfoImage(
          thumbnailUrl:
              'https://tse4.mm.bing.net/th?id=OIP.YhUlntbH98C7Vi-uKF0xlwHaFj&pid=Api'),
      InfoImage(
          thumbnailUrl:
              'https://tse1.mm.bing.net/th?id=OIP.w25ZoCwIb9HMq9xZSNUWmgHaH4&pid=Api')
    ];
