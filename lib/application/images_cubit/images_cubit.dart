import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_multi_image_picker/domain/upload_image/images_repository.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesRepository imagesRepository;

  ImagesCubit({
    required this.imagesRepository,
  }) : super(ImagesStateInitial());

  getCurrentState() {
    return state;
  }

  changeCurrentState({required ImagesState imagesState}) {
    emit(imagesState);
  }

  uploadImagesData({required List<XFile>? imageFiles}) async {
    if (kDebugMode) {
      print("uploadImagesData Started");
      print("imageFiles $imageFiles");
    }
    try {
      emit(ImagesStateLoading());
      dynamic imagesInfoResponse =
          await imagesRepository.uploadImages(uploadImages: imageFiles);
      if (kDebugMode) {
        print("imagesInfoResponse $imagesInfoResponse");
      }
      emit(ImagesStateUploaded(imagesInfoResponse: imagesInfoResponse));
    } catch (e, s) {
      emit(ImagesStateError(imagesInfoResponse: e));
      if (kDebugMode) {
        print("Error $e $s");
      }
    }
  }
}
