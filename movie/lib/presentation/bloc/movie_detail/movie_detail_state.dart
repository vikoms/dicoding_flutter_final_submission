part of 'movie_detail_bloc.dart';

@immutable
class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;
  final RequestState movieState;
  final String watchlistMessage;
  final String message;
  final bool isAddedToWatchlist;

  const MovieDetailState({
    this.movieDetail = null,
    this.movieRecommendations = const [],
    this.movieState = RequestState.Loading,
    this.watchlistMessage = '',
    this.message = '',
    this.isAddedToWatchlist = false,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    RequestState? movieState,
    String? watchlistMessage,
    String? message,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieState: movieState ?? this.movieState,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieRecommendations,
        movieState,
        watchlistMessage,
        message,
        isAddedToWatchlist,
      ];
}
