import 'dart:async';

import 'package:djangoflow_deep_link_interface/src/data/djangoflow_deep_link_repository_base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DeepLinkCubitBase<T> extends Cubit<T?> {
  DeepLinkCubitBase(super.initialState, this.repository);

  final DjangoflowDeepLinkRepositoryBase<T> repository;

  late final StreamSubscription<T> _deepLinkStreamSub;

  void startListening() {
    _deepLinkStreamSub = repository.getLinkStream().listen((link) {
      emit(link);
    });
  }

  @override
  Future<void> close() {
    _deepLinkStreamSub.cancel();
    return super.close();
  }
}
