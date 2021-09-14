import 'package:geolocator/geolocator.dart';

//@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class SendLocationState extends LocationState {
  late Position _position;
  SendLocationState(this._position);
}

class SuccessState extends LocationState {
  final String isSuccessful;
  SuccessState(this.isSuccessful);
}

class LoadingState extends LocationState {
  final bool isloading;
  LoadingState(this.isloading);
}

class ErrorState extends LocationState {
  final Exception error;
  ErrorState(this.error);
}
