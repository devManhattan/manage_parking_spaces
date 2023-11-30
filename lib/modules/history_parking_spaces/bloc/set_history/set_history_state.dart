part of 'set_history_bloc.dart';

abstract class SetHistoryState extends Equatable {
  const SetHistoryState();
  
  @override
  List<Object> get props => [];
}

final class SetHistoryInitial extends SetHistoryState {}

final class SetHistoryLoading extends SetHistoryState {}

final class SetHistoryLoaded extends SetHistoryState {}
