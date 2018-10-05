import 'package:giphy_app/home/home_page_actions.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:redux/redux.dart';

final Reducer<HomePageState> homePageReducer = combineReducers([
  TypedReducer(_updateRequesting),
  TypedReducer(_updateFetched),
  TypedReducer(_updateFailed),
]);

HomePageState _updateRequesting(
  HomePageState state,
  HomePageRequest action,
) {
  return state.copyWith(
    status: LoadingStatus.fetching,
  );
}

HomePageState _updateFetched(
  HomePageState state,
  HomePageFetched action,
) {
  return state.copyWith(
    status: LoadingStatus.fetched,
    gifObject: action.gifObject,
  );
}

HomePageState _updateFailed(
  HomePageState state,
  HomePageFailed action,
) {
  return state.copyWith(
    status: LoadingStatus.failed,
    error: action.exception,
  );
}
