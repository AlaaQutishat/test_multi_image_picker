import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_multi_image_picker/application/images_cubit/images_cubit.dart';

class ImagesViewPage extends StatelessWidget {
  final List<XFile>? imageFiles;
  const ImagesViewPage({Key? key, required this.imageFiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "The Images Which you select for upload",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(),
              const Text("Picked Files:"),
              const Divider(),
              imageFiles != null
                  ? Wrap(
                      children: imageFiles!.map(
                        (image) {
                          return Card(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(File(image.path)),
                            ),
                          );
                        },
                      ).toList(),
                    )
                  : Container(),
              const Spacer(),
              buildResponseResult()
            ],
          ),
        );
      },
    );
  }

  BlocBuilder<ImagesCubit, ImagesState> buildResponseResult() {
    return BlocBuilder<ImagesCubit, ImagesState>(
      builder: (context, state) {
        if (state is ImagesStateUploaded) {
          return Text(
            state.imagesInfoResponse.toString(),
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),
          );
        } else if (state is ImagesStateError) {
          return Text(
            state.imagesInfoResponse.toString(),
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          );
        }
        return Container();
      },
    );
  }
}
