import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:giphy_app/home/home_page.dart';
import 'package:giphy_app/home/home_page_reducer.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<HomePageState>(
    homePageReducer,
    middleware: [
      thunkMiddleware,
      LoggingMiddleware.printer(),
    ],
    initialState: HomePageState.init(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Demo',
      theme: ThemeData.dark(),
      home: StoreProvider<HomePageState>(
        store: store,
        child: Scaffold(
          body: HomePage(title: 'Gifs!'),
        ),
      ),
    );
  }
}
