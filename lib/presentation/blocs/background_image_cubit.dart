import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/background_image_repository.dart';
import '../../data/models/background_image_model.dart';

abstract class BackgroundImageState {}

class BackgroundImageInitial extends BackgroundImageState {}

class BackgroundImageLoading extends BackgroundImageState {}

class BackgroundImageLoaded extends BackgroundImageState {
  final BackgroundImageModel image;
  BackgroundImageLoaded(this.image);
}

class BackgroundImageError extends BackgroundImageState {
  final String error;
  BackgroundImageError(this.error);
}

class BackgroundImageCubit extends Cubit<BackgroundImageState> {
  final BackgroundImageRepository repository;

  BackgroundImageCubit(this.repository) : super(BackgroundImageInitial());

  void fetchBackgroundImage() async {
    emit(BackgroundImageLoading());
    try {
      final image = await repository.fetchBackgroundImage();
      emit(BackgroundImageLoaded(image));
    } catch (e) {
      emit(BackgroundImageError(e.toString()));
    }
  }
}
