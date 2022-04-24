part of 'network_connection_bloc.dart';

abstract class NetworkConnectionEvent extends Equatable {
  const NetworkConnectionEvent();

  @override
  List<Object> get props => [];
}

class InactiveNetworkEvent extends NetworkConnectionEvent {}

class ActiveNetworkEvent extends NetworkConnectionEvent {}
