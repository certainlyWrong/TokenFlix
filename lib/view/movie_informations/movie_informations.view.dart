import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tokenflix/model/movie.model.dart';
import 'package:tokenflix/view/components/movie_card.dart';
import 'package:tokenflix/model/movie_informations.model.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text(widget.movieInformations.title)),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: CachedNetworkImage(
                        width: width,
                        height: 300,
                        fit: BoxFit.cover,
                        imageUrl: widget.movieInformations.backdropUrl,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              Text(
                                widget.movieInformations.title,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: width,
                          height: 300,
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
                          const SizedBox(height: 200),
                          MovieCard(
                            movie: widget.movie,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Load overview

                SizedBox(
                  width: width < 600 ? width : 600,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: FloatingActionButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.play_arrow_rounded),
                                Text('play'.toUpperCase()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.play_arrow_rounded),
                                Text('trailer'.toUpperCase()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Runtime:',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '${widget.movieInformations.runtime} min',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Genres:',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                                ...widget.movieInformations.genres
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          e,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                            Row(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Release date:',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    widget.movieInformations.releaseDate
                                        .toString()
                                        .substring(0, 10),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          widget.movieInformations.overview,
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
