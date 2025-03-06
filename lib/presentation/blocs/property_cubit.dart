import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/property_repository.dart';
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository repository;

  PropertyCubit(this.repository) : super(PropertyInitial());

  void fetchProperties() async {
    emit(PropertyLoading());
    try {
      final properties = await repository.fetchProperties();
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}
