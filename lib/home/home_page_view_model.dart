import 'package:giphy_app/home/home_page_state.dart';

class HomePageViewModel {
  HomePageViewModel(
    this.state, {
    this.onPressedShuffle,
  });

  final HomePageState state;

  final Function onPressedShuffle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageViewModel &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          onPressedShuffle == other.onPressedShuffle;

  @override
  int get hashCode => state.hashCode ^ onPressedShuffle.hashCode;
}
