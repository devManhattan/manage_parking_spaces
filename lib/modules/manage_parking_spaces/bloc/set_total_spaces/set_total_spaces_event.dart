part of 'set_total_spaces_bloc.dart';

abstract class SetTotalSpacesEvent extends Equatable {
  const SetTotalSpacesEvent();

  @override
  List<Object> get props => [];
}

class SetTotalSpacesSetEvent extends SetTotalSpacesEvent {
  final int spaces;
  const SetTotalSpacesSetEvent({required this.spaces});
  @override
  List<Object> get props => [];
}
