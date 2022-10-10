import 'package:flutter_sembast/sembast_with_provider/database/sembast_database_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sembastProvider = Provider(
  (ref) => SembastDatabase(),
);

final initializationProvider = FutureProvider(
  (ref) async {
    await ref.watch(sembastProvider).createDatabase();
  },
);

final localStorageProvider = Provider(
  (ref) => LocalStorageService(ref.watch(sembastProvider)),
);
