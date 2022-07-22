part of 'images_cubit.dart';

@immutable
abstract class ImagesState {}

class ImagesStateInitial extends ImagesState {}

class ImagesStateLoading extends ImagesState {}

class ImagesStateUploaded extends ImagesState {
  final dynamic imagesInfoResponse;
  ImagesStateUploaded({required this.imagesInfoResponse});
}

class ImagesStateError extends ImagesState {
  final dynamic imagesInfoResponse;
  ImagesStateError({required this.imagesInfoResponse});
}
