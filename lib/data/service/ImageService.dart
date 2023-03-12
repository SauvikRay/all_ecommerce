import 'package:dio/dio.dart';

class ImageService{
  static Future<dynamic> uploadFile(filePath) async {

    try {
      FormData formData =
      FormData.fromMap({
        "picture":
        await MultipartFile.fromFile(filePath, filename: "dp")});

      Response response =
      await Dio().post(
          "https://www.skybuybd.com/api/v1/image-search",
          data: formData,

      );
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}