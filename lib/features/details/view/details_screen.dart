import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit/details_cubit.dart';

class DetailsScreen extends StatelessWidget {
  final int id;
  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..prepareMovie(id),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state is DetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if(state is DetailsLoaded) {
            return Scaffold();
          } else if(state is DetailsLoading) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text('Something went wrong while opening details', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            );
          }
        },
      ),
    );
  }
}
