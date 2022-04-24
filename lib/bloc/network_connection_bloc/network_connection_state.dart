part of 'network_connection_bloc.dart';

enum NetworkState { active, inactive }

class NetworkConnectionState extends Equatable {
  final NetworkState networkState;
  const NetworkConnectionState({
    required this.networkState,
  });

  factory NetworkConnectionState.initial() {
    return const NetworkConnectionState(networkState: NetworkState.active);
  }

  @override
  List<Object> get props => [networkState];

  NetworkConnectionState copyWith({
    NetworkState? networkState,
  }) {
    return NetworkConnectionState(
      networkState: networkState ?? this.networkState,
    );
  }
}
