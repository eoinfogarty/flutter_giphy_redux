import 'package:giphy_app/_data/gif_response.dart';
import 'package:meta/meta.dart';

enum LoadingStatus {
  initial,
  fetching,
  failed,
  fetched,
}

@immutable
class HomePageState {
  HomePageState({this.status, this.error, this.gifObject});

  final LoadingStatus status;
  final Exception error;
  final GifObject gifObject;

  factory HomePageState.init() => HomePageState(
      status: LoadingStatus.initial, error: null, gifObject: GifObject.empty());

  HomePageState copyWith(
      {LoadingStatus status, Exception error, GifObject gifObject}) {
    return HomePageState(
      status: status ?? this.status,
      error: error ?? this.error,
      gifObject: gifObject ?? this.gifObject,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          error == other.error &&
          gifObject == other.gifObject;

  @override
  int get hashCode => status.hashCode ^ error.hashCode ^ gifObject.hashCode;
}
