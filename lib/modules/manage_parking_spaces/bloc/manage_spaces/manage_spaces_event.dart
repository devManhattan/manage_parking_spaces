part of 'manage_spaces_bloc.dart';

abstract class ManageSpacesEvent extends Equatable {
  const ManageSpacesEvent();

  @override
  List<Object> get props => [];
}

class ManageSpacesLoadEvent extends ManageSpacesEvent {
  @override
  List<Object> get props => [];
}

class ManageSpacesSetvent extends ManageSpacesEvent {
  final int index;
  const ManageSpacesSetvent({required this.index});
  @override
  List<Object> get props => [];
}


class ManageSpacesUnsetvent extends ManageSpacesEvent {
  final int index;
  const ManageSpacesUnsetvent({required this.index});
  @override
  List<Object> get props => [];
}
