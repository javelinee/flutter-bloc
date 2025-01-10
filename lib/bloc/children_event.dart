import '../models/model.dart';

abstract class ChildrenEvent {}

class FetchDataEvent extends ChildrenEvent {}

class LoadDataEvent extends ChildrenEvent {
  final List<Children>? children;
  LoadDataEvent(this.children);
}
