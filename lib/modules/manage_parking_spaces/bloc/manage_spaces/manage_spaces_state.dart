part of 'manage_spaces_bloc.dart';

abstract class ManageSpacesState extends Equatable {
  const ManageSpacesState();

  @override
  List<Object> get props => [];
}

final class ManageSpacesInitial extends ManageSpacesState {}

final class ManageSpacesloading extends ManageSpacesState {}

final class ManageSpacesLoaded extends ManageSpacesState {
  final List<SpaceModel> spaces;
  const ManageSpacesLoaded({required this.spaces});
}

final class ManageSpacesError extends ManageSpacesState {}
