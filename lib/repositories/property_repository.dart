
import 'package:lekki_proj_demo/models/api_response.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/models/repository_response.dart';
import 'package:lekki_proj_demo/services/api_service.dart';
import 'package:lekki_proj_demo/utils/constants.dart';
import 'package:lekki_proj_demo/utils/getit_setup.dart';

class PropertyRepository extends ApiService{
  // fetches all property with possible query parameters
  Future<RepositoryResponse<List<Property>>> getProperties() async {
    APIResponse res = await get(ApiEndpoints.lekkiProperty);

    if (res.success){
      List<Property> data = [];

      for (var item in res.data){
        data.add(Property.fromJson(item));
      }

      return RepositoryResponse(data: data);
    }
    return RepositoryResponse.error(res.error);
  }

  // get property with an id
  Future<RepositoryResponse<List<Property>>> getProperty(String id) async {
    APIResponse res = await get('${ApiEndpoints.lekkiProperty}/$id');

    if (res.success){
      return RepositoryResponse(data: res.data);
    }
    return RepositoryResponse.error(res.error);
  }

  // create new property
  Future<RepositoryResponse> postProperty(Map<String, dynamic> data) async {
    final res = await post(ApiEndpoints.lekkiProperty, data: data);

    if (res.success){
      return RepositoryResponse(data: res.data);
    }
    return RepositoryResponse.error(res.error);
  }

  // updates existing property
  Future<RepositoryResponse> patchProperty(String id, Map<String, dynamic> data) async {
    final res = await patch('${ApiEndpoints.lekkiProperty}/$id', data: data);

    if (res.success){
      return RepositoryResponse(data: res.data);
    }
    return RepositoryResponse.error(res.error);
  }
}

PropertyRepository propertyRepository = getIt<PropertyRepository>();
