import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/models/movie_model.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/utils/sized_boxes.dart';
import 'package:wilson_wings/view_models/movie_details_bloc/movie_deatails_bloc.dart';
import 'package:wilson_wings/views/widgets/wilson_elevated_button.dart';
import 'package:wilson_wings/views/widgets/wilson_snack_bars.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movieModel;
  const MovieDetailsScreen({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Adaptive.h(2)),
          child: Column(
            children: [
              Text(movieModel.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              sizedBoxHeight30,
              Row(
                children: [
                  SizedBox(
                    height: Adaptive.h(25),
                    width: Adaptive.w(30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${movieModel.posterPath}',
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      }, loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                                backgroundColor:
                                    const Color.fromARGB(255, 207, 234, 255),
                                color: primaryColor,
                                strokeWidth: 6),
                          );
                        }
                      }, fit: BoxFit.fill),
                    ),
                  ),
                  BlocListener<MovieDeatailsBloc, MovieDeatailsState>(
                    listener: (context, state) {
                      if (state is MovieBookedState) {
                        successSnackBar(context, 'Movie Booked Successfully');
                      } else if (state is MovieBookedFailedState) {
                        errorSnackBar(context, 'Movie Booking Faield');
                      }
                    },
                    child: SizedBox(width: Adaptive.w(2)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Adaptive.w(55),
                        child: Text('Movie Name : ${movieModel.title}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text('Movie ID : ${movieModel.id.toString()}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      Text(
                          'Language : ${movieLanguageAlter(movieModel.originalLanguage)}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.blue, fontSize: 16)),
                      SizedBox(
                        width: Adaptive.w(55),
                        child: Text(
                            'Release Date : ${movieModel.releaseDate.substring(0, 10)}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ),
                      SizedBox(
                        width: Adaptive.w(55),
                        child: Text(
                            'Adult : ${movieModel.adult ? 'Adult' : 'Not Adult'}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ),
                      sizedBoxHeight30,
                      Text('Rating : ${movieModel.voteAverage}/10',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text('Vote Count : ${movieModel.voteCount.toString()}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              sizedBoxHeight30,
              Text(movieModel.overview,
                  style: TextStyle(color: hintColor, fontSize: 16)),
              sizedBoxHeight30,
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(Adaptive.h(2)),
        child: WilsonElevatedButton(
            function: () {
              BlocProvider.of<MovieDeatailsBloc>(context)
                  .add(BookMovieButtonClickedEvent());
            },
            text: 'Book Movie'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String movieLanguageAlter(String movieLanguage) {
    if (movieLanguage == 'en') {
      return 'English';
    } else if (movieLanguage == 'ml') {
      return 'Malayalam';
    } else if (movieLanguage == 'fr') {
      return 'French';
    } else if (movieLanguage == 'pl') {
      return 'Polish';
    } else if (movieLanguage == 'hi') {
      return 'Hindi';
    } else {
      return movieLanguage;
    }
  }
}
