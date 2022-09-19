import 'package:flutter/material.dart';
import 'package:tokenflix/model/movie.model.dart';
import 'package:tokenflix/model/movie_informations.model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tokenflix/view/home/components/movie_card.dart';

class MovieInformationPage extends StatefulWidget {
  final MovieModel movie;
  final MovieInformationsModel movieInformations;

  const MovieInformationPage({
    super.key,
    required this.movieInformations,
    required this.movie,
  });

  @override
  State<MovieInformationPage> createState() => _MovieInformationPageState();
}

class _MovieInformationPageState extends State<MovieInformationPage> {
  late ValueNotifier<bool> isLoaded;

  @override
  void initState() {
    isLoaded = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    isLoaded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(widget.movieInformations.title)),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: width * 1.6,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: CachedNetworkImage(
              width: width,
              height: width * 0.6,
              fit: BoxFit.cover,
              imageUrl: widget.movieInformations.backdropUrl,
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              placeholder: (context, url) => Container(
                width: width,
                height: width * 0.6,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: RefreshProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: width / 2),
                MovieCard(
                  movie: widget.movie,
                  width: width / 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
