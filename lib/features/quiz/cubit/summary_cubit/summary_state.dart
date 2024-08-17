part of 'summary_cubit.dart';

sealed class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

final class SummaryInitial extends SummaryState {}

final class SummaryProgress extends SummaryState {}

final class SummarySuccess extends SummaryState {
  final Quiz quiz;
  const SummarySuccess({required this.quiz});
  @override
  List<Object> get props => [quiz];
}

final class SummaryFailure extends SummaryState {
  final String message;
  const SummaryFailure({required this.message});
  @override
  List<Object> get props => [message];
}
