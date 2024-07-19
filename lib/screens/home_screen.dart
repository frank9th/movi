import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movi/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';

import 'models.dart';
import 'movie_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final moviePro = MovieProvider();
  List<Movie> oraginalMovieList = [];
  List<Movie> movieList = [];
  bool isLoading = true;

  getMovies() async {
    List<Movie> data = await moviePro.fetchTrendingMovies();
    setState(() {
      oraginalMovieList = data;
      movieList = data;
      isLoading = false;
    });
  }

  List<Movie> filterMovies(String searchQuery) {
    List<Movie> searchedList = movieList
        .where((movie) => movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    setState(() {
      movieList = searchedList;
    });
    return searchedList;
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Image.asset(
                'assets/logo.jpeg',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movit',
                  style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Your Movie Companion..', // Replace with your tagline
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey, // Adjust tagline color if needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Movies',
                    prefixIcon: Icon(Icons.search),
                  ),
                  //onChanged: (text) => moviesProvider.setSearchQuery(text),
                  onChanged: (text) {
                    if (oraginalMovieList.isNotEmpty) {
                      if (text.isNotEmpty) {
                        filterMovies(text);
                      } else {
                        setState(() {
                          movieList = oraginalMovieList;
                        });
                      }
                    }
                  }),
            ),
            // Featured Movies/Trending
            MovieCarousel(
              movies: movieList,
            ),

            // Genres

            // Genres
            FutureBuilder(
              future: moviePro.fetchGenres(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error fetching genres');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  final genres = moviesProvider.genres;
                  return Wrap(
                    children: genres.map((genre) => Chip(label: Text(genre.name))).toList(),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Top Rated Movies'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black45, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  height: 400,
                  child: MovieListSection(
                    title: 'Top Rated Movies',
                    movieList: movieList,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;
  const MovieCarousel({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: movies
          .map((movie) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movie)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        aspectRatio: 2 / 3,
        enlargeCenterPage: true,
      ),
    );
  }
}

class MovieListSection extends StatelessWidget {
  final String title;
  final List<Movie> movieList;

  const MovieListSection({
    Key? key,
    required this.title,
    required this.movieList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Movie> getTopRatedMovies() {
      // Sort movies by voteAverage in descending order (highest first)
      print('the solting list: ${movieList.length}');
      return movieList.toList()..sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
    }

    final List<Movie> ratedList = getTopRatedMovies();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ratedList.length,
      itemBuilder: (context, index) => MovieListItem(movie: ratedList[index]),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final Movie movie;
  const MovieListItem({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movie)));
      },
      child: ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          ),
          title: Text(movie.title),
          subtitle: Text(movie.releaseDate)),
    );
  }
}
