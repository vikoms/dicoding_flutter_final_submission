part of 'trailer_bloc.dart';

@immutable
abstract class TrailerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrailerInitial extends TrailerState {}

class TrailerError extends TrailerState {
  final String message;
  TrailerError(this.message);
  @override
  List<Object?> get props => [
        message,
      ];
}

class TrailerLoading extends TrailerState {}

class TrailerLoaded extends TrailerState {
  final List<Video> videos;
  TrailerLoaded(this.videos);
  @override
  List<Object?> get props => [
        videos,
      ];
}
