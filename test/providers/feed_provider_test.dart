import 'package:ecommerce/provider/feed_provider.dart';
import 'package:ecommerce/provider/repositories/feed_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  FeedProvider feedProvider;
  MockFeedRepository mockFeedRepository;

  setUp(() {
    mockFeedRepository = MockFeedRepository();
    feedProvider = FeedProvider(feedRepository: mockFeedRepository);
  });

  group("Fetching All Feed", () {
    test("Fetching All Data", () async {
      when(mockFeedRepository.fetchAllFeeds()).thenAnswer((_) async => []);
      feedProvider.fetchAllFeeds();
      await untilCalled(mockFeedRepository.fetchAllFeeds());
      verify(mockFeedRepository.fetchAllFeeds());
    });
  });
}
