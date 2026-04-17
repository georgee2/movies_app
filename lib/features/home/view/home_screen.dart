import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../details/view/details_screen.dart';
import '../view_model/home_cubit.dart';
import '../component/home_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getMovies(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator(),);
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state.nowPlaying.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).width * 0.5,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                    itemCount: state.nowPlaying.length,
                    itemBuilder: (context, index, pageIndex) {
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(id: state.nowPlaying[index].id))),
                        child: Stack(
                          children: [
                            Image.network(
                              state.nowPlaying[index].posterPath,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              bottom: 24,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/now_playing.png'),
                                  const SizedBox(width: 4),
                                  Text(
                                    'NOW PLAYING',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if(state.popular.isNotEmpty)
                Expanded(
                  child: HomeList(title: 'Popular on Netflix', movies: state.popular),
                ),
                if(state.topRated.isNotEmpty)
                Expanded(
                  child: HomeList(title: 'Top Rated', movies: state.topRated),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
