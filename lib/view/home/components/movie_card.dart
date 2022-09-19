import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokenflix/model/movie.model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tokenflix/view/home/page/movie_informations.page.dart';
import 'package:tokenflix/controller/movie_informations.controller.dart';

class MovieCard extends StatefulWidget {
  final double? width, height;
  final MovieModel movie;

  const MovieCard({
    super.key,
    this.width,
    this.height,
    required this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late ValueNotifier<bool> isFavorite;

  @override
  void initState() {
    isFavorite = ValueNotifier<bool>(widget.movie.isFavorite);
    super.initState();
  }

  @override
  dispose() {
    isFavorite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          debugPrint('MovieCard: ${widget.movie.title}');

          Provider.of<MovieInformationsController>(context, listen: false)
              .movieInformations(widget.movie.id)
              .then(
            (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieInformationPage(
                    movie: widget.movie,
                    movieInformations: value,
                  ),
                ),
              );
            },
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                width: widget.width,
                height: widget.height,
                imageUrl: widget.movie.posterUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      Text(
                        widget.movie.title,
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: RefreshProgressIndicator(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_border_purple500_rounded,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.movie.voteAverage.toString(),
                        style: const TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.movie.isFavorite = !widget.movie.isFavorite;
                      if (widget.movie.isFavorite) {
                        isFavorite.value = true;
                        // Provider.of<MovieController>(context).saveFavorites(
                        //   movie: widget.movie,
                        // );
                      } else {
                        isFavorite.value = false;
                        // Provider.of<MovieController>(context).removeFavorites(
                        //   movie: widget.movie,
                        // );
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: isFavorite,
                      builder: (context, bool isFavorite, child) {
                        return Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: Colors.red,
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
