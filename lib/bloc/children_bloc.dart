import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_one/bloc/children_event.dart';
import 'package:flutter_one/bloc/children_state.dart';

import '../services/services.dart';

class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final Services services;

  ChildrenBloc(this.services) : super(ChildrenInitialState()) {
    on<FetchDataEvent>((event, emit) async {
      emit(ChildrenLoadingState());

      try {
        final data = await services.fetchData();

        if (data != null) {
          emit(ChildrenLoadedState(data));
        } else {
          emit(ChildrenErrorState("Failed to fetch data"));
        }
      } catch (e) {
        emit(ChildrenErrorState(e.toString()));
      }
    });

    on<LoadDataEvent>((event, emit) async {
      emit(ChildrenLoadedState(event.children));
    });
  }
}
