import '../models/model.dart';

abstract class ChildrenState {}

class ChildrenInitialState extends ChildrenState {}

class ChildrenLoadingState extends ChildrenState {}

class ChildrenLoadedState extends ChildrenState {
  final List<Children>? children;
  ChildrenLoadedState(this.children);
}

class ChildrenErrorState extends ChildrenState {
  final String message;
  ChildrenErrorState(this.message);
}
