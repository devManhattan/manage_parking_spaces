part of 'check_first_access_bloc.dart';

abstract class CheckFirstAccessState {}

final class CheckFirstAccessInitial extends CheckFirstAccessState {}

final class CheckFirstAccessLoading extends CheckFirstAccessState {}

final class CheckFirstAccessIsFirst extends CheckFirstAccessState {}

final class CheckFirstAccessIsNotFirst extends CheckFirstAccessState {}

final class CheckFirstAccessError extends CheckFirstAccessState {}
