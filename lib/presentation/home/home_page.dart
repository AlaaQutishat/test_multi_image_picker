import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_multi_image_picker/application/images_cubit/images_cubit.dart';
import 'package:test_multi_image_picker/presentation/images_view/images_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFiles;

  openImages() async {
    try {
      var pickedFiles = await imagePicker.pickMultiImage(
          imageQuality: 50, // <- Reduce Image quality
          maxHeight: 500, // <- reduce the image size
          maxWidth: 500);
      if (pickedFiles != null) {
        imageFiles = pickedFiles;
        setState(() {});
      } else {
        if (kDebugMode) {
          print("No image is selected.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while picking file.");
      }
    }
  }

  uploadImages() async {
    if (imageFiles != null) {
      context.read<ImagesCubit>().uploadImagesData(imageFiles: imageFiles);
    } else {
      if (kDebugMode) {
        print("imageFiles is null");
      }
    }
  }

  showImages() async {
    if (imageFiles != null) {
      // context.read<ImagesCubit>().uploadImagesData(imageFiles: imageFiles);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImagesViewPage(
                  imageFiles: imageFiles,
                )),
      );
    } else {
      if (kDebugMode) {
        print("imageFiles is null");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Test apk for multiple image picker"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: buildBody(),
    );
  }

  BlocBuilder buildBody() {
    return BlocBuilder<ImagesCubit, ImagesState>(
      builder: (context, state) {
        if (state is ImagesStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              buildOpenImagesBtn(),
              buildUploadImagesBtn(),
              buildShowImagesBtn(),
              const Spacer(),
              buildResponseResult()
            ],
          ),
        );
      },
    );
  }

  ElevatedButton buildUploadImagesBtn() {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
        ),
        onPressed: () {
          uploadImages();
        },
        child: const Text("Upload Images"));
  }

  ElevatedButton buildShowImagesBtn() {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
        ),
        onPressed: () {
          showImages();
        },
        child: const Text("Show Images"));
  }

  ElevatedButton buildOpenImagesBtn() {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
        ),
        onPressed: () {
          openImages();
        },
        child: const Text("Open Images"));
  }

  BlocBuilder<ImagesCubit, ImagesState> buildResponseResult() {
    return BlocBuilder<ImagesCubit, ImagesState>(
      builder: (context, state) {
        if (state is ImagesStateUploaded) {
          return Expanded(
            child: Text(
              state.imagesInfoResponse.toString(),
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
          );
        } else if (state is ImagesStateError) {
          return Expanded(
            child: Text(
              state.imagesInfoResponse.toString(),
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          );
        }
        return Container();
      },
    );
  }
}
