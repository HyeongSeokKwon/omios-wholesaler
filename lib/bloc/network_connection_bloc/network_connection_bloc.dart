import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_connection_event.dart';
part 'network_connection_state.dart';

class NetworkConnectionBloc
    extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {
  NetworkConnectionBloc() : super(NetworkConnectionState.initial()) {
    on<InactiveNetworkEvent>(inactiveNetwork);
    on<ActiveNetworkEvent>(activeNetwork);
  }

  void inactiveNetwork(
      InactiveNetworkEvent event, Emitter<NetworkConnectionState> emit) {
    emit(state.copyWith(networkState: NetworkState.inactive));
  }

  void activeNetwork(
      ActiveNetworkEvent event, Emitter<NetworkConnectionState> emit) {
    emit(state.copyWith(networkState: NetworkState.active));
  }
}
