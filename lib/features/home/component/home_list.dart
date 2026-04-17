import 'package:flutter/material.dart';

import '../../details/view/details_screen.dart';
import '../model/movie_model.dart';

class HomeList extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  const HomeList({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(id: movies[index].id))),
                child: Row(
                  children: [
                    Image.network(movies[index].posterPath, width: 100, fit: BoxFit.cover),
                    const SizedBox(width: 6),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
