part of 'set_total_spaces_bloc.dart';

abstract class SetTotalSpacesState extends Equatable {
  const SetTotalSpacesState();

  @override
  List<Object> get props => [];
}

final class SetTotalSpacesInitial extends SetTotalSpacesState {}

final class SetTotalSpacesLoading extends SetTotalSpacesState {}

final class SetTotalSpacesLoaded extends SetTotalSpacesState {}

final class SetTotalSpacesError extends SetTotalSpacesState {}
