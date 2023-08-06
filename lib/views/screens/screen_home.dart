import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/models/movie_model.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/utils/sized_boxes.dart';
import 'package:wilson_wings/view_models/home_screen_bloc/home_screen_bloc.dart';
import 'package:wilson_wings/views/widgets/wilson_movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeScreenBloc>(context).add(GetAllLatestMovies());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(4)),
          child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
            listenWhen: (previous, current) => current is HomeScreenActionState,
            buildWhen: (previous, current) => current is! HomeScreenActionState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AllMoviesFetchedState) {
                List<MovieModel> allMovies = state.allMovies;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight20,
                    const Text('Latest Movies',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    sizedBoxHeight10,
                    Expanded(
                        child: allMovies.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) {
                                  return WilsonMovieCard(
                                      movieModel: allMovies[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return sizedBoxHeight10;
                                },
                                itemCount: allMovies.length)
                            : const Center(
                                child: Text('No Movies Found!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))))
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: const Color.fromARGB(255, 207, 234, 255),
                      color: primaryColor,
                      strokeWidth: 6),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.data == ConnectivityResult.none ||
                snapshot.data == null) {
              return SizedBox(
                width: Adaptive.w(98),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.white),
                    )),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
