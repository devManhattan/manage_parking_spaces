part of 'gest_history_bloc.dart';

abstract class GestHistoryState extends Equatable {
  const GestHistoryState();

  @override
  List<Object> get props => [];
}

final class GestHistoryInitial extends GestHistoryState {}

final class GestHistoryLoading extends GestHistoryState {}

final class GestHistoryLoaded extends GestHistoryState {
  final int totalSpaces;
  final Map historyForSpace;
  const GestHistoryLoaded(
      {required this.historyForSpace, required this.totalSpaces});
}

final class GestHistoryError extends GestHistoryState {}
