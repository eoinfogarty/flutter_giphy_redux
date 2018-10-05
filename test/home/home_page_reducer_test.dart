import 'package:giphy_app/_data/gif_response.dart';
import 'package:giphy_app/home/home_page_actions.dart';
import 'package:giphy_app/home/home_page_reducer.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:test/test.dart';

void main() {
  group('HomePageReducer', () {
    test('reduces to fetching state', () {
      final state = HomePageState.init();

      final reducedState = homePageReducer(
        state,
        HomePageRequest(),
      );

      expect(reducedState.status, LoadingStatus.fetching);
      expect(state, isNot(reducedState));
    });

    test('reduces to fetched state', () {
      final state = HomePageState.init();
      final gifObject = GifObject.empty();

      final reducedState = homePageReducer(
        state,
        HomePageFetched(gifObject),
      );

      expect(reducedState.status, LoadingStatus.fetched);
      expect(reducedState.gifObject, gifObject);
      expect(state, isNot(reducedState));
    });

    test('reduces to error state', () {
      final state = HomePageState.init();
      final error = Exception('hoge');

      final reducedState = homePageReducer(
        state,
        HomePageFailed(error),
      );

      expect(reducedState.status, LoadingStatus.failed);
      expect(reducedState.error, error);
      expect(state, isNot(reducedState));
    });
  });
}
