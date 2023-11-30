part of 'check_first_access_bloc.dart';

abstract class CheckFirstAccessEvent  extends Equatable {}

class FirstAccessCheckEvent extends CheckFirstAccessEvent {
  @override
  List<Object> get props => [];
}
