import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_genres.dart';
import 'package:movie/domain/usecases/get_movies_by_genre.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:search/presentation/bloc/bloc/search_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_series_by_genre.dart';
import 'package:series/domain/usecases/get_series_genres.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([
  SearchMovies,
  SearchSeries,
  NetworkInfo,
  GetMovieGenres,
  GetSeriesGenres,
  GetMoviesByGenre,
  GetSeriesByGenre,
])
void main() {
  late SearchBloc searchBloc;
  late MockGetMovieGenres mockGetMovieGenres;
  late MockGetSeriesGenres mockGetSeriesGenres;
  late MockGetMoviesByGenre mockGetMoviesByGenre;
  late MockGetSeriesByGenre mockGetSeriesByGenre;
  late MockSearchMovies mockSearchMovies;
  late MockSearchSeries mockSearchSeries;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchSeries = MockSearchSeries();
    mockNetworkInfo = MockNetworkInfo();
    mockGetMovieGenres = MockGetMovieGenres();
    mockGetSeriesGenres = MockGetSeriesGenres();
    mockGetMoviesByGenre = MockGetMoviesByGenre();
    mockGetSeriesByGenre = MockGetSeriesByGenre();

    searchBloc = SearchBloc(
      mockSearchMovies,
      mockSearchSeries,
      mockGetMovieGenres,
      mockGetMoviesByGenre,
      mockGetSeriesByGenre,
      mockGetSeriesGenres,
      mockNetworkInfo,
    );
  });

  test('Initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: '/path/to/backdrop.jpg',
    genreIds: [1, 2, 3],
    id: 123,
    originalTitle: 'Original Title',
    overview: 'This is a movie about something.',
    popularity: 10.0,
    posterPath: '/path/to/poster.jpg',
    releaseDate: '2022-01-01',
    title: 'spiderman',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  final tSeries = Series(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genreIds: [1, 2, 3],
    id: 1,
    name: "name",
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.2,
    posterPath: "posterPath",
    voteAverage: 1.2,
    voteCount: 12,
  );

  final tGenre = Genre(id: 1, name: "name");

  final tMovieList = <Movie>[tMovie];
  final tGenreList = <Genre>[tGenre];
  final tSeriesList = <Series>[tSeries];

  final tQuery = "spiderman";
  final tPage = 1;
  final tGenreId = 1;
  final MOVIE = "SEARCH_MOVIES";
  final SERIES = "SEARCH_SERIES";

  group("Search Movies", () {
    blocTest<SearchBloc, SearchState>(
      'emits [Loading,HasData] when data movies is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery, tPage))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeMovies(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasDataMovies(result: tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery, tPage));
      },
    );

    blocTest<SearchBloc, SearchState>(
        'emits [Loading,Error] when get search is unsuccessfully.',
        build: () {
          when(mockSearchMovies.execute(tQuery, tGenreId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return searchBloc;
        },
        act: (bloc) => bloc.add(OnQueryChangeMovies(tQuery)),
        expect: () => [
              SearchLoading(),
              SearchError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery, tPage));
        });
  });

  group("Search Series", () {
    blocTest<SearchBloc, SearchState>(
      'emits [Loading,HasData] when data series is gotten successfully',
      build: () {
        when(mockSearchSeries.execute(tQuery, tPage))
            .thenAnswer((_) async => Right(tSeriesList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeSeries(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasDataSeries(result: tSeriesList),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery, tPage));
      },
    );

    blocTest<SearchBloc, SearchState>(
        'emits [Loading,Error] when get search is unsuccessfully.',
        build: () {
          when(mockSearchSeries.execute(tQuery, tGenreId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return searchBloc;
        },
        act: (bloc) => bloc.add(OnQueryChangeSeries(tQuery)),
        expect: () => [
              SearchLoading(),
              SearchError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockSearchSeries.execute(tQuery, tPage));
        });
  });

  group("Get Movie By Genre", () {
    blocTest<SearchBloc, SearchState>(
        'emits [SearchHasDataMovies] when get movies is successfully.',
        build: () {
          when(mockGetMoviesByGenre.execute(tGenreId, tPage))
              .thenAnswer((_) async => Right(tMovieList));
          return searchBloc;
        },
        act: (bloc) => bloc.add(OnGetMoviesByGenre(tGenreId)),
        expect: () => <SearchState>[
              SearchHasDataMovies(
                result: tMovieList,
                selectedGenreId: tGenreId,
              )
            ],
        verify: (bloc) {
          verify(mockGetMoviesByGenre.execute(tGenreId, tPage));
        });

    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataMovies] with hasReachedMax true when no more movies are available',
      build: () {
        when(mockGetMoviesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Right([]));
        return searchBloc;
      },
      act: (bloc) {
        bloc.emit(SearchHasDataMovies(result: tMovieList));
        bloc.add(OnGetMoviesByGenre(tGenreId));
      },
      expect: () => [
        SearchHasDataMovies(
            result: tMovieList, selectedGenreId: tGenreId, hasReachedMax: true),
      ],
    );
    blocTest<SearchBloc, SearchState>(
      'emits [SearchError] when there is an error fetching movies',
      build: () {
        when(mockGetMoviesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnGetMoviesByGenre(tGenreId)),
      expect: () => [
        SearchError('Server Failure'),
      ],
    );
  });

  group("Get Series By Genre", () {
    blocTest<SearchBloc, SearchState>(
      "Emit [SearchHasData] when series are fetched successfully",
      build: () {
        when(mockGetSeriesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Right(tSeriesList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnGetSeriesByGenre(tGenreId)),
      expect: () => [
        SearchHasDataSeries(result: tSeriesList),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchError] when there is an error fetching series',
      build: () {
        when(mockGetSeriesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnGetSeriesByGenre(tGenreId)),
      expect: () => [
        SearchError('Server Failure'),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataSeries] with hasReachedMax true when no more series are available',
      build: () {
        when(mockGetSeriesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Right([]));
        return searchBloc;
      },
      act: (bloc) {
        bloc.emit(SearchHasDataSeries(result: tSeriesList));
        bloc.add(OnGetSeriesByGenre(tGenreId));
      },
      expect: () => [
        SearchHasDataSeries(
            result: tSeriesList,
            selectedGenreId: tGenreId,
            hasReachedMax: true),
      ],
    );
  });

  group("Get More Movies", () {
    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataMovies] with selectedGenreId when movies are fetch successfully',
      build: () {
        when(mockGetMoviesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Right(tMovieList));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        searchBloc.emit(
            SearchHasDataMovies(result: tMovieList, selectedGenreId: tGenreId));
        return searchBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnGetMoreMovies()),
      expect: () => <SearchState>[
        SearchHasDataMovies(
          result: tMovieList + tMovieList,
          hasReachedMax: false,
          selectedGenreId: tGenreId,
          query: "",
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataMovies] with query when movies are fetch successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery, tPage))
            .thenAnswer((_) async => Right(tMovieList));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        searchBloc.emit(SearchHasDataMovies(result: tMovieList, query: tQuery));
        return searchBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnGetMoreMovies()),
      expect: () => <SearchState>[
        SearchHasDataMovies(
          result: tMovieList + tMovieList,
          hasReachedMax: false,
          query: tQuery,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataMovies] with hasReachedMax true when movies is empty',
      build: () {
        when(mockSearchMovies.execute(tQuery, tPage))
            .thenAnswer((_) async => Right([]));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        return searchBloc;
      },
      act: (bloc) {
        searchBloc.emit(SearchHasDataMovies(result: tMovieList, query: tQuery));
        bloc.add(OnGetMoreMovies());
      },
      expect: () => <SearchState>[
        SearchHasDataMovies(
          result: tMovieList,
          hasReachedMax: true,
          query: tQuery,
        ),
      ],
    );
  });

  group("Get More Series", () {
    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataSeries] with selectedGenreId when Series are fetch successfully',
      build: () {
        when(mockGetSeriesByGenre.execute(tGenreId, tPage))
            .thenAnswer((_) async => Right(tSeriesList));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        searchBloc.emit(SearchHasDataSeries(
          result: tSeriesList,
          selectedGenreId: tGenreId,
        ));
        return searchBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnGetMoreSeries()),
      expect: () => <SearchState>[
        SearchHasDataSeries(
          result: tSeriesList + tSeriesList,
          hasReachedMax: false,
          selectedGenreId: tGenreId,
          query: "",
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataSeries] with query when series are fetch successfully',
      build: () {
        when(mockSearchSeries.execute(tQuery, tPage))
            .thenAnswer((_) async => Right(tSeriesList));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        searchBloc
            .emit(SearchHasDataSeries(result: tSeriesList, query: tQuery));
        return searchBloc;
      },
      wait: const Duration(milliseconds: 500),
      act: (bloc) => bloc.add(OnGetMoreSeries()),
      expect: () => <SearchState>[
        SearchHasDataSeries(
          result: tSeriesList + tSeriesList,
          hasReachedMax: false,
          query: tQuery,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchHasDataSeries] with hasReachedMax true when series is empty',
      build: () {
        when(mockSearchSeries.execute(tQuery, tPage))
            .thenAnswer((_) async => Right([]));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        return searchBloc;
      },
      act: (bloc) {
        searchBloc
            .emit(SearchHasDataSeries(result: tSeriesList, query: tQuery));
        bloc.add(OnGetMoreSeries());
      },
      expect: () => <SearchState>[
        SearchHasDataSeries(
          result: tSeriesList,
          hasReachedMax: true,
          query: tQuery,
        ),
      ],
    );
  });

  group("Get Genre", () {
    blocTest<SearchBloc, SearchState>(
      'emits [Loading,HasData] when get genre is successfully.',
      build: () {
        when(mockGetMovieGenres.execute())
            .thenAnswer((_) async => Right(tGenreList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnGetGenres(MOVIE)),
      expect: () => [SearchLoading(), GenreHasData(tGenreList)],
    );
    blocTest<SearchBloc, SearchState>(
        'emits [Loading,HasData] get genre series is successfully.',
        build: () {
          when(mockGetSeriesGenres.execute())
              .thenAnswer((_) async => Right(tGenreList));
          return searchBloc;
        },
        act: (bloc) => bloc.add(OnGetGenres(SERIES)),
        expect: () => [
              SearchLoading(),
              GenreHasData(tGenreList),
            ],
        verify: (bloc) {
          verify(mockGetSeriesGenres.execute());
        });

    blocTest<SearchBloc, SearchState>(
        'emits [Loading,Empty] get genre is failure.',
        build: () {
          when(mockGetSeriesGenres.execute())
              .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
          return searchBloc;
        },
        act: (bloc) => bloc.add(OnGetGenres(SERIES)),
        expect: () => [
              SearchLoading(),
              SearchEmpty(),
            ],
        verify: (bloc) {
          verify(mockGetSeriesGenres.execute());
        });
  });
}
