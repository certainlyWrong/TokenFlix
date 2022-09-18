import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokenflix/model/movie.model.dart';
import 'package:tokenflix/controller/movie.controller.dart';
import 'package:tokenflix/view/home/components/movie_card.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height,
        cardWidthProportion = width / 2.6,
        cardheightProportion = height / 4;

    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        child: FutureBuilder(
          future: Provider.of<MovieController>(context).movies,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<MovieModel> movies = snapshot.data as List<MovieModel>;
              return Center(
                child: Wrap(
                  children: [
                    for (int i = 0; i < movies.length; i++)
                      MovieCard(
                        width: cardWidthProportion,
                        height: cardheightProportion,
                        movie: movies[i],
                      ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
