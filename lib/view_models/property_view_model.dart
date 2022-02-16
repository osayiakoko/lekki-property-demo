import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/models/property_image.dart';
import 'package:lekki_proj_demo/repositories/app_repository.dart';
import 'package:lekki_proj_demo/repositories/property_repository.dart';

class PropertyViewModel extends ChangeNotifier{
  bool _loading = false;
  bool get isLoading => _loading;

  set isLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _uploading = false;
  bool get isUploading => _uploading;

  set isUploading(bool value) {
    _uploading = value;
    notifyListeners();
  }

  String errorMsg = "";

  var itemInProcess = [];
  
  List<Property>? properties;
  List<Property>? rawproperties;

  // filter values
  int bedroom = 0;
  int sittingRoom = 0;
  int kitchen = 0;
  int bathroom = 0;
  int toilet = 0;
  String propertyOwner = '';


  // methods

  // fetch proeprties
  Future<bool> fetchProperties() async {

    isLoading = true;

    final res = await propertyRepository.getProperties();
    if (res.success){
      properties = res.data;
      rawproperties = res.data;
      isLoading = false;
      return true;
    }
    return _handleError(res.error.toString());
  }

  // upload image for new property
  Future<PropertyImage?> uploadImage(File file) async {

    isUploading = true;
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename:fileName),
    });

    final res = await appRepository.uploadImage(formData);

    isUploading = false;
    if (res.success){
      return res.data;
    }else{
      return null;
    }
  }

  // add property
  Future<bool> addProperty(Property property) async {

    isLoading = true;
    final res = await propertyRepository.postProperty(property.toJson());

    if (res.success){
      rawproperties!.insert(0, Property.fromJson(res.data));
      clearFilter();
      isLoading = false;
      return true;
    }
    return _handleError(res.error.toString());
  }

  // update property
  Future<bool> updateProperty(Property property) async {

    isLoading = true;
    String id = property.id!;
    Map<String, dynamic> reqData = property.toJson();

    reqData.remove('id');
    reqData.remove('images');
    reqData.remove('address');
    reqData.remove('validFrom');
    reqData.remove('propertyOwner');
    reqData.remove('type');

    final res = await propertyRepository.patchProperty(
      id, 
      reqData
    );
    if (res.success){
      rawproperties = rawproperties!.map((prop) => prop.id == id ? property : prop).toList();
      clearFilter();
      isLoading = false;
      return true;
    }
    return _handleError(res.error.toString());
  }

  // filter property
  void filterProperty()  {
    properties = rawproperties!.where((prop) => 
      prop.bedroom >= bedroom &&
      prop.sittingRoom >= bedroom &&
      prop.kitchen >= bedroom &&
      prop.bathroom >= bathroom &&
      prop.toilet >= toilet
    ).toList();
    notifyListeners();
  }

  // clear filter
  void clearFilter(){
    bedroom = 0;
    sittingRoom = 0;
    kitchen = 0;
    bathroom = 0;
    toilet = 0;

    properties = rawproperties;
    notifyListeners();
  }

  // handle api call error
  bool _handleError(String errMsg){
    errorMsg = errMsg;
    isLoading = false;
    return false;
  }
}

final propertyViewModelProvider = ChangeNotifierProvider<PropertyViewModel>((ref) {
  return PropertyViewModel();
});
