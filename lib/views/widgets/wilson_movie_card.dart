import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wilson_wings/models/movie_model.dart';
import 'package:wilson_wings/utils/colors.dart';
import 'package:wilson_wings/utils/sized_boxes.dart';
import 'package:wilson_wings/views/screens/screen_movie_deatails.dart';

class WilsonMovieCard extends StatelessWidget {
  final MovieModel movieModel;

  const WilsonMovieCard({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movieModel: movieModel)));
      },
      child: Container(
        padding: EdgeInsets.all(Adaptive.h(1.3)),
        height: Adaptive.h(22),
        width: Adaptive.w(100),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(84, 168, 229, 0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            SizedBox(
              height: Adaptive.h(100),
              width: Adaptive.w(27),
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
            SizedBox(width: Adaptive.w(4)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Adaptive.w(55),
                  child: Text(movieModel.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                Text(movieModel.id.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                Text(movieLanguageAlter(movieModel.originalLanguage),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.blue, fontSize: 16)),
                SizedBox(
                  width: Adaptive.w(55),
                  child: Text(movieModel.releaseDate.substring(0, 10),
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ),
                sizedBoxHeight30,
                Text('${movieModel.voteAverage}/10',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
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
