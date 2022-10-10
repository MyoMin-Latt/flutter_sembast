import 'package:flutter_sembast/sembast_with_state_notifier_provider/database/sembast_database_state_notifier.dart';
import 'package:flutter_sembast/sembast_with_state_notifier_provider/state_notifier_provider/state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../sembast_with_provider/provider/provider.dart';

final localServiceProvider = Provider(
  (ref) => LocalStorageServiceWithState(ref.watch(sembastProvider)),
);

final localStorageStateNotifierProvider =
    StateNotifierProvider<SembastNotifer, SembastState>(
  (ref) => SembastNotifer(ref.watch(localServiceProvider)),
);
