import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/models/property.dart';
import 'package:lekki_proj_demo/utils/validators.dart';
import 'package:lekki_proj_demo/view_models/property_view_model.dart';
import 'package:lekki_proj_demo/views/property_details_view.dart';
import 'package:lekki_proj_demo/widgets/input_field.dart';
import 'package:lekki_proj_demo/widgets/rect_rounded_button.dart';
import 'package:lekki_proj_demo/widgets/text_area_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class UpdateProperty extends ConsumerStatefulWidget {
  const UpdateProperty(this.property, {Key? key}) : super(key: key);

  final Property property;

  static const routeName = "/update-property-view";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdatePropertyState();
}

class _UpdatePropertyState extends ConsumerState<UpdateProperty> {

  final _formKey = GlobalKey<FormState>();

  final _bedroomController = TextEditingController();
  final _sittingroomController = TextEditingController();
  final _bathroomController = TextEditingController();
  final _toiletController = TextEditingController();
  final _kitchenController = TextEditingController();
  final _validToController = TextEditingController();
  final _descriptionController = TextEditingController();


  DateTime _validTo = DateTime.now().add(const Duration(days: 7));


  @override
  void initState() {
    super.initState();
    _bedroomController.text = widget.property.bedroom.toString();
    _sittingroomController.text = widget.property.sittingRoom.toString();
    _bathroomController.text = widget.property.bathroom.toString();
    _toiletController.text = widget.property.toilet.toString();
    _kitchenController.text = widget.property.kitchen.toString();
    _descriptionController.text = widget.property.description;
    _validTo = widget.property.validTo;
    _validToController.text = "${_validTo.day}/${_validTo.month}/${_validTo.year}";
  }

  @override
  Widget build(BuildContext context) {

    final propertyVM = ref.watch(propertyViewModelProvider);

    return IgnorePointer(
      ignoring: propertyVM.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update property"),
          elevation: 0,
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
                        Row(
                          children: [
                            Expanded(child: InputField("Bedrooms", _bedroomController, validator: Validators.numberValidator)),
                            SizedBox(width: 16.w,),
                            Expanded(
                              child: InputField("Sitting rooms", _sittingroomController, validator: Validators.numberValidator)
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: InputField("Kitchen", _kitchenController, validator: Validators.numberValidator)),
                            SizedBox(width: 16.w,),
                            Expanded(child: InputField("Bathrooms", _bathroomController, validator: Validators.numberValidator)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: InputField("Toilet", _toiletController, validator: Validators.numberValidator)),
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
                title: "Update",
                isLoading: propertyVM.isLoading,
                onPressed: () async{
                  if (_formKey.currentState!.validate()){
    
                    Property propertyUpdate = widget.property.copyWith(
                        bedroom: int.parse(_bedroomController.text), 
                        sittingRoom: int.parse(_sittingroomController.text), 
                        kitchen: int.parse(_kitchenController.text), 
                        bathroom: int.parse(_bathroomController.text), 
                        toilet: int.parse(_toiletController.text), 
                        description: _descriptionController.text, 
                        validTo: _validTo, 
                      );
    
                    bool success = await propertyVM.updateProperty(propertyUpdate);
    
                    if (success){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, PropertyDetailsView.routeName, arguments: propertyUpdate);
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
    _bedroomController.dispose();
    _sittingroomController.dispose();
    _bathroomController.dispose();
    _toiletController.dispose();
    _kitchenController.dispose();
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
