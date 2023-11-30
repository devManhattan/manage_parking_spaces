part of 'set_history_bloc.dart';

abstract class SetHistoryEvent extends Equatable {
  const SetHistoryEvent();

  @override
  List<Object> get props => [];
}

class SetHistorySetEvent extends SetHistoryEvent {
  final bool available;
  final int number;
  const SetHistorySetEvent({
    required this.available,
    required this.number,
  });
  @override
  List<Object> get props => [];
}
