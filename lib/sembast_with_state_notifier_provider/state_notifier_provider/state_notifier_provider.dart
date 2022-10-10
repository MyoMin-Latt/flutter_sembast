import 'package:flutter_sembast/sembast_with_state_notifier_provider/database/sembast_database_state_notifier.dart';
import 'package:flutter_sembast/sembast_with_state_notifier_provider/database/student_model_state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'state_notifier_provider.freezed.dart';

@freezed
class SembastState with _$SembastState {
  const factory SembastState.initial() = _Initial;
  const factory SembastState.loading() = _Loading;
  const factory SembastState.empty() = _Empty;
  const factory SembastState.success(List<StudentModelWithState> student) =
      _Success;
  const factory SembastState.error(String error) = _Error;
}

class SembastNotifer extends StateNotifier<SembastState> {
  final LocalStorageServiceWithState localStorageService;
  SembastNotifer(this.localStorageService)
      : super(const SembastState.initial());
  Future<void> getAllStudents() async {
    state = const SembastState.loading();
    Future.delayed(const Duration(seconds: 3));
    final data = await localStorageService.getAllStudent();
    state =
        data.isEmpty ? const SembastState.empty() : SembastState.success(data);
  }
}
