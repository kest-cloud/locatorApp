import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locator/cubit/location_state.dart';
import 'package:locator/helpers/googleapi.dart';
import 'package:locator/models/location_model.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Position? position;
  List<LocationModel> locationModel = [];

  sendLocationMethod(Position position) async {
    try {
      GoogleApi googleApi = GoogleApi();

      LocationModel locationModel =
          LocationModel(coordinates: [position.longitude, position.latitude]);

      emit(LoadingState(false));

      ///loading state while sendind data

      final result = await googleApi.sendLocation(locationModel);
      print("location stored: $result");

      emit(SuccessState(result));
    } on Exception catch (e) {
      emit(ErrorState(e));
    }
  }
}

Future<bool> sendLocation() {
  return Future.delayed(Duration(seconds: 5), () {
    return true;
  });
}
