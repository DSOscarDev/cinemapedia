import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMoviebyId);
});
/*
  {
    '505642':Moview(),        
    '505651':Moview(),
    '505670':Moview(),
    '505681':Moview(),
    '505690':Moview(),
  }
*/

typedef GetmovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{
  
  final GetmovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }):super({});

  Future<void> loadMovie(String movieId) async{
    if(state[movieId]!= null) return;

    print('realizando peticion http');

    final movie = await getMovie(movieId);

    state = {...state, movieId:movie};

  }

}