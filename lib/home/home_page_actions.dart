import 'package:giphy_app/_data/gif_repository.dart';
import 'package:giphy_app/_data/gif_response.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<HomePageState> shuffleGif([
  GifRepository repository = const GifRepository(),
]) {
  return (store) {
    store.dispatch(HomePageRequest());
    repository
        .getRandomTrending()
        .then((gifObject) => store.dispatch(HomePageFetched(gifObject)))
        .catchError((exception) => store.dispatch(HomePageFailed(exception)));
  };
}

class HomePageRequest {}

class HomePageFetched {
  HomePageFetched(this.gifObject);

  final GifObject gifObject;
}

class HomePageFailed {
  HomePageFailed(this.exception);

  final Exception exception;
}
