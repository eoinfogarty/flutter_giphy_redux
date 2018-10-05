import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_app/_data/gif_repository.dart';
import 'package:giphy_app/_data/gif_response.dart';
import 'package:giphy_app/home/home_page_actions.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class MockRepository extends Mock implements GifRepository {}

void main() {
  final mockRepository = MockRepository();

  group('HomePageActions', () {
    testWidgets('gets a random gif ', (WidgetTester tester) async {
      final response = GifObject.empty();

      when(mockRepository.getRandomTrending())
          .thenAnswer((_) => Future.value(response));

      final expectedActions = [
        HomePageRequest(),
        HomePageFetched(GifObject.empty()),
      ];

      actionLog.clear();

      final store = createTestStore();
      await thunkMiddleware.call(store, shuffleGif(mockRepository), addToLog);

      expect(actionLog.length, expectedActions.length);
      _checkActionOrderAndType(expectedActions);
    });

    test('Fails to get a product list', () async {
      final expectedActions = [
        HomePageRequest(),
        HomePageFailed(Exception('hoge')),
      ];

      when(mockRepository.getRandomTrending())
          .thenAnswer((_) => Future.error(Exception('hoge')));

      actionLog.clear();

      final store = createTestStore();
      await thunkMiddleware.call(store, shuffleGif(mockRepository), addToLog);

      expect(actionLog.length, expectedActions.length);
      _checkActionOrderAndType(expectedActions);
    });
  });
}

void _checkActionOrderAndType(List<Object> expectedActions) {
  // actions are same type and in same order
  for (var x = 0; x < actionLog.length; x++) {
    expect(actionLog[x].runtimeType, expectedActions[x].runtimeType);
  }
}

Store<HomePageState> createTestStore() {
  return Store<HomePageState>(
    actionLogReducer,
    initialState: HomePageState.init(),
    middleware: [thunkMiddleware],
  );
}

final Reducer<HomePageState> actionLogReducer = (
  HomePageState state,
  dynamic action,
) {
  addToLog(action);
  return state;
};

// for tracking actions taken by thunk and middleware
final List<dynamic> actionLog = <dynamic>[];
final Function(dynamic) addToLog = (dynamic action) => actionLog.add(action);
