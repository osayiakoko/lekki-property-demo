import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/models/property_image.dart';
import 'package:lekki_proj_demo/utils/constants.dart';
import 'package:lekki_proj_demo/utils/validators.dart';
import 'package:lekki_proj_demo/view_models/property_view_model.dart';
import 'package:lekki_proj_demo/widgets/custom_network_image.dart';
import 'package:lekki_proj_demo/widgets/input_field.dart';
import 'package:lekki_proj_demo/widgets/loading_indicator.dart';
import 'package:lekki_proj_demo/widgets/rect_rounded_button.dart';
import 'package:lekki_proj_demo/widgets/select_field.dart';
import 'package:lekki_proj_demo/widgets/text_area_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class AddPropertyView extends ConsumerStatefulWidget {
  const AddPropertyView({Key? key}) : super(key: key);

  static const routeName = "/add-property-view";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPropertyViewState();
}

class _AddPropertyViewState extends ConsumerState<AddPropertyView> {

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  final _formKey = GlobalKey<FormState>();

  final _ownerController = TextEditingController();
  final _typeController = TextEditingController();
  final _bedroomController = TextEditingController();
  final _sittingroomController = TextEditingController();
  final _bathroomController = TextEditingController();
  final _toiletController = TextEditingController();
  final _kitchenController = TextEditingController();
  final _validFromController = TextEditingController();
  final _validToController = TextEditingController();
  final _descriptionController = TextEditingController();


  String _addressValue = states[0];
  List<PropertyImage> _images = [];
  DateTime _validFrom = DateTime.now();
  DateTime _validTo = DateTime.now().add(const Duration(days: 7));

  @override
  Widget build(BuildContext context) {

    final propertyVM = ref.watch(propertyViewModelProvider);

    return IgnorePointer(
      ignoring: propertyVM.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add property"),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () async {
                if(propertyVM.isUploading) return;
                
                final possibleImg = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _selectedImage = possibleImg;
                });
                  if (_selectedImage != null){
                    File uprightImage = await FlutterExifRotation.rotateImage(path: _selectedImage!.path);
                    PropertyImage? img = await propertyVM.uploadImage(uprightImage);
                    if(img != null){
                      setState(() {
                        _images.add(img);
                      });
                    }else{
                      showTopSnackBar(
                          context,
                          const CustomSnackBar.error(
                            message: "Unable to upload image"
                          ),
                      );
                    }
                  }
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: propertyVM.isUploading 
                  ? const LoadingIndicator(color: Colors.white, size: 18,) 
                  : const Icon(Icons.image),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: _images.isEmpty ? 0 : 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            itemBuilder: (context, i) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.h),
                              child: CustomNetworkImage(
                                imageUrl: _images[i].path,
                                width: 100.r,
                                height: 50.r,
                                fullRadius: true,
                              ),
                            )
                          )
                        ),
                        SizedBox(height: 10.h,),
                        SelectField(
                          label: "Address", 
                          items: states.map<DropdownMenuItem<String>>((state) =>
                            DropdownMenuItem<String>(value: state, child: Text(state))
                          ).toList(), 
                          value: _addressValue, 
                          onChange: (v) => setState(() => _addressValue = v)
                        ),
                        InputField("owner", _ownerController, intValue: false, validator: Validators.validateIsEmpty,),
                        Row(
                          children: [
                            Expanded(
                              child: InputField("Property type", _typeController, intValue:false, 
                              validator: Validators.validateIsEmpty,)
                            ),
                            SizedBox(width: 16.w,),
                            Expanded(child: InputField("Bedrooms", _bedroomController, validator: Validators.numberValidator)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputField("Sitting rooms", _sittingroomController, validator: Validators.numberValidator)
                            ),
                            SizedBox(width: 16.w,),
                            Expanded(child: InputField("Kitchen", _kitchenController, validator: Validators.numberValidator)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: InputField("Bathrooms", _bathroomController, validator: Validators.numberValidator)),
                            SizedBox(width: 16.w,),
                            Expanded(child: InputField("Toilet", _toiletController, validator: Validators.numberValidator)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                "Valid from", 
                                _validFromController,
                                onTap: () => _selectDate(context, _validFrom, _validFromController),
                                readOnly: true,
                                validator: Validators.validateIsEmpty,
                              ),
                              // child: InputField("Bathrooms", _bathroomController, validator: Validators.numberValidator)
                            ),
                            SizedBox(width: 16.w,),
                            Expanded(
                              child: InputField(
                                "Valid to", 
                                _validToController,
                                onTap: () => _selectDate(context, _validTo, _validToController),
                                readOnly: true,
                                validator: Validators.validateIsEmpty,
                              ),
                            ),
                          ],
                        ),
                        TextAreaField(
                          "Description",
                          controller: _descriptionController,
                          validator: Validators.validateIsEmpty,
                        )
                      ],
                    ),
                  ),
                )
              ),
              RectRoundedButton(
                title: "Add",
                isLoading: propertyVM.isLoading,
                onPressed: () async{
                  if (_formKey.currentState!.validate()){
                    bool success = await propertyVM.addProperty(
                      Property(
                        address: _addressValue, 
                        type: _typeController.text, 
                        bedroom: int.parse(_bedroomController.text), 
                        sittingRoom: int.parse(_sittingroomController.text), 
                        kitchen: int.parse(_kitchenController.text), 
                        bathroom: int.parse(_bathroomController.text), 
                        toilet: int.parse(_toiletController.text), 
                        propertyOwner: _ownerController.text, 
                        description: _descriptionController.text, 
                        validFrom: _validFrom, 
                        validTo: _validTo, 
                        images: _images,
                      )
                    );
    
                    if (success){
                      Navigator.pop(context);
                    }else{
                      showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                            message: propertyVM.errorMsg
                          ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ownerController.dispose();
    _typeController.dispose();
    _bedroomController.dispose();
    _sittingroomController.dispose();
    _bathroomController.dispose();
    _toiletController.dispose();
    _kitchenController.dispose();
    _validFromController.dispose();
    _validToController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context, DateTime date, TextEditingController dateController) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: DateTime(date.year+20),
    );

    if (selected != null && selected != date){
      setState(() => date=selected);
      dateController.text = "${selected.day}/${selected.month}/${selected.year}";
    }
  }

}
