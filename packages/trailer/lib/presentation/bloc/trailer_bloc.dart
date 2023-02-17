import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trailer/domain/entities/video.dart';
import 'package:trailer/domain/usecases/get_trailer.dart';

part 'trailer_event.dart';
part 'trailer_state.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final GetTrailer getTrailer;
  TrailerBloc({
    required this.getTrailer,
  }) : super(TrailerInitial()) {
    on<OnGetTrailer>((event, emit) async {
      emit(TrailerLoading());
      final result = await getTrailer.execute(event.path, event.id);
      result.fold((error) {
        emit(TrailerError(error.message));
      }, (videos) {
        emit(TrailerLoaded(videos));
      });
    });
  }
}
