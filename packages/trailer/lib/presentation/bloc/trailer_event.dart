part of 'trailer_bloc.dart';

@immutable
abstract class TrailerEvent extends Equatable {}

class OnGetTrailer extends TrailerEvent {
  final String path;
  final int id;
  OnGetTrailer({required this.path, required this.id});
  @override
  List<Object?> get props => [
        path,
        id,
      ];
}
