import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multi_image_picker/application/images_cubit/images_cubit.dart';
import 'package:test_multi_image_picker/domain/api/api_repository.dart';
import 'package:test_multi_image_picker/domain/upload_image/images_repository.dart';
import 'package:test_multi_image_picker/presentation/home/home_page.dart';

final APIRepository apiRepository = APIRepository();
final ImagesRepository imagesRepository = ImagesRepository(apiRepository);

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImagesRepository>(
            create: (context) => ImagesRepository(apiRepository)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ImagesCubit>(
            create: (BuildContext context) => ImagesCubit(
              imagesRepository: imagesRepository,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Test Multi Image Picker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const HomePage(title: 'Test Multi Image Picker'),
        ),
      ),
    );
  }
}
