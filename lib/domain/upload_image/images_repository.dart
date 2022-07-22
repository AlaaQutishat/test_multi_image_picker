import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_multi_image_picker/domain/api/api_repository.dart';

class ImagesRepository {
  late final APIRepository _apiRepository;

  ImagesRepository(this._apiRepository);

  Future<dynamic> uploadImages({required List<XFile>? uploadImages}) async {
    List uploadImageList = [];
    for (int i = 0; i < uploadImages!.length; i++) {
      if (kDebugMode) {
        print("uploadImages[$i].path:${uploadImages[i].path}");
        print("uploadImages[$i].path:${uploadImages[i].name}");
      }
      uploadImageList.add(await MultipartFile.fromFileSync(uploadImages[i].path,
          contentType: MediaType.parse(
            "image/jpeg",
          )));
    }
    if (kDebugMode) {
      print("uploadImageList:$uploadImageList");
    }

    var data = FormData.fromMap({"child_id": "17", "image[]": uploadImageList});

    Response response = await _apiRepository.post(
      "",
      data: data,
      options: Options(
        contentType: "image/jpeg",
      ),
    );
    if (kDebugMode) {
      print("response.data :${response.data}");
    }
    return response.data;
  }
}
