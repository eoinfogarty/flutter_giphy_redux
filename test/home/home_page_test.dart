import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_app/_data/gif_response.dart';
import 'package:giphy_app/home/home_page.dart';
import 'package:giphy_app/home/home_page_state.dart';
import 'package:giphy_app/home/home_page_view_model.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

class MockViewModel extends Mock implements HomePageViewModel {}

void main() {
  group('HomePage ', () {
    MockViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockViewModel();

      when(mockViewModel.state).thenReturn(HomePageState.init());
    });

    Future<Null> _buildHomePage(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: HomePageContent('title', mockViewModel),
        ),
      );
    }

    testWidgets('shows loading progress', (WidgetTester tester) async {
      when(mockViewModel.state).thenReturn(
        mockViewModel.state.copyWith(
          status: LoadingStatus.fetching,
        ),
      );

      await _buildHomePage(tester);

      expect(find.byKey(HomePageContent.loadingKey), findsOneWidget);
      expect(find.byKey(HomePageContent.errorKey), findsNothing);
      expect(find.byKey(HomePageContent.contentKey), findsNothing);
    });

    testWidgets('shows error snackbar', (WidgetTester tester) async {
      when(mockViewModel.state).thenReturn(
        mockViewModel.state.copyWith(
          status: LoadingStatus.failed,
          error: Exception('hoge'),
        ),
      );

      await _buildHomePage(tester);

      expect(find.byKey(HomePageContent.loadingKey), findsNothing);
      expect(find.byKey(HomePageContent.errorKey), findsOneWidget);
      expect(find.byKey(HomePageContent.contentKey), findsNothing);
    });

    testWidgets('shows content', (WidgetTester tester) async {
      when(mockViewModel.state).thenReturn(
        mockViewModel.state.copyWith(
          status: LoadingStatus.fetched,
          gifObject: GifObject.empty(),
        ),
      );

      await provideMockedNetworkImages(() async {
        await _buildHomePage(tester);
      });

      expect(find.byKey(HomePageContent.loadingKey), findsNothing);
      expect(find.byKey(HomePageContent.errorKey), findsNothing);
      expect(find.byKey(HomePageContent.contentKey), findsOneWidget);
    });
  });
}
