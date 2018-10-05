import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:giphy_app/home/home_page_actions.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:giphy_app/home/home_page_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<HomePageState, HomePageViewModel>(
      converter: (store) {
        return HomePageViewModel(
          store.state,
          onPressedShuffle: () {
            store.dispatch(shuffleGif());
          },
        );
      },
      onInit: (store) {
        store.dispatch(shuffleGif());
      },
      onDidChange: (store) {
        if (store.state.status == LoadingStatus.failed) {
          _showErrorSnackbar(context);
        }
      },
      distinct: true,
      builder: (context, viewModel) => HomePageContent(title, viewModel),
    );
  }

  void _showErrorSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Something went wrong...'),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class HomePageContent extends StatelessWidget {
  HomePageContent(this.title, this.viewModel);

  static const Key loadingKey = Key('loadingView');
  static const Key errorKey = Key('errorView');
  static const Key contentKey = Key('contentView');

  final String title;
  final HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildPageContent(viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.onPressedShuffle,
        tooltip: 'Shuffle trending gifs',
        child: Icon(Icons.shuffle),
      ),
    );
  }

  Widget _buildPageContent(HomePageViewModel viewModel) {
    switch (viewModel.state.status) {
      case LoadingStatus.fetching:
        return _buildProgressIndicator();
      case LoadingStatus.fetched:
        return _buildGifImage(viewModel);
      case LoadingStatus.failed:
      case LoadingStatus.initial:
        return Container(key: errorKey);
    }

    throw Exception('Non handled status ${viewModel.state.status}');
  }

  Center _buildProgressIndicator() {
    return Center(
      key: loadingKey,
      child: Container(
        alignment: Alignment.center,
        width: 48.0,
        height: 48.0,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Center _buildGifImage(HomePageViewModel viewModel) {
    return Center(
      key: contentKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              viewModel.state.gifObject.url,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
