
import 'package:dio/dio.dart';
import 'package:lekki_proj_demo/models/property_image.dart';
import 'package:lekki_proj_demo/models/repository_response.dart';
import 'package:lekki_proj_demo/services/api_service.dart';
import 'package:lekki_proj_demo/utils/constants.dart';
import 'package:lekki_proj_demo/utils/getit_setup.dart';


class AppRepository extends ApiService{

  Future<RepositoryResponse<PropertyImage>> uploadImage(FormData data) async {
    final res = await post(ApiEndpoints.imageUpload, data: data);

    if (res.success){
      return  RepositoryResponse(data: PropertyImage.fromJson(res.data));
    }
    return RepositoryResponse.error(res.error);
  }
}

AppRepository appRepository = getIt<AppRepository>();
