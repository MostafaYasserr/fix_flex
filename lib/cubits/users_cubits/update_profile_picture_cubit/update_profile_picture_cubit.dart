import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fix_flex/cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import 'package:http_parser/http_parser.dart';


part 'update_profile_picture_state.dart';

class UpdateProfilePictureCubit extends Cubit<UpdateProfilePictureState> {
  UpdateProfilePictureCubit() : super(UpdateProfilePictureInitial());

  static UpdateProfilePictureCubit get(context) => BlocProvider.of(context);

  File? image;
  final ImagePicker imagePicker = ImagePicker();
  final String galleryOption = 'Gallery';
  final String cameraOption = 'Camera';

  Future<void> updateProfilePicture({
    required String id,
    required String token,
    required File? imageFile,
    required BuildContext context
  }) async {
    emit(UpdateProfilePictureLoading());
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
            imageFile!.path,
            filename: basename(imageFile.path),
            contentType: MediaType('image', 'jpeg'))
      });
      final response = await DioApiHelper.patchData(
        url: EndPoints.updateProfilePicture(),
        data: formData,
      );
      if (response.statusCode == 200) {
        GetMyDataCubit.get(context).getMyData();
        emit(UpdateProfilePictureSuccess());
        image= null;
      } else {
        emit(UpdateProfilePictureFailure());
      }
    } catch (e) {
      emit(UpdateProfilePictureFailure());
    }
  }

  void onImageClick() {
    emit(ImageClicked());
  }

  Future<void> pickImage(String sourceType) async {
    try {
      final pickedImage = await imagePicker.pickImage(source: sourceType == 'Gallery' ? ImageSource.gallery : ImageSource.camera);
      if (pickedImage != null) {
        image = File(pickedImage.path);
        emit(UpdateProfilePicturePickedImage());
      }
    } catch (e) {
      emit(UpdateProfilePictureFailure());
    }
  }
  void resetUpdateProfilePictureCubit() {
    image = null;
    emit(UpdateProfilePictureInitial());
  }
}
