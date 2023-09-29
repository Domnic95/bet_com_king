import 'package:bet_mobile/providers/bannernotifier.dart';
import 'package:bet_mobile/providers/fixturenotifier.dart';
import 'package:bet_mobile/providers/newsnotifier.dart';
import 'package:bet_mobile/providers/oddsnotifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final newsProvider = ChangeNotifierProvider(
  (ref) => NewsProvider(),
);
final fixtureProvider = ChangeNotifierProvider(
  (ref) => FixtureProvider(),
);
final bannerProvider = ChangeNotifierProvider(
  (ref) => BannerProvider(),
);
final oddsProvider = ChangeNotifierProvider(
  (ref) => OddsProvider(),
);