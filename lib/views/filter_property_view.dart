import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';
import 'package:lekki_proj_demo/utils/validators.dart';
import 'package:lekki_proj_demo/view_models/property_view_model.dart';
import 'package:lekki_proj_demo/widgets/input_field.dart';
import 'package:lekki_proj_demo/widgets/rect_rounded_button.dart';


class FilterPropertyView extends ConsumerStatefulWidget {
  const FilterPropertyView({Key? key}) : super(key: key);

  static const routeName = "/filter-property-view";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterPropertyViewState();
}

class _FilterPropertyViewState extends ConsumerState<FilterPropertyView> {

  final _formKey = GlobalKey<FormState>();

  final _bedroomController = TextEditingController();
  final _sittingroomController = TextEditingController();
  final _bathroomController = TextEditingController();
  final _toiletController = TextEditingController();
  final _kitchenController = TextEditingController();


  @override
  void initState() {
    super.initState();

    var propertyVM = ref.read(propertyViewModelProvider);

    _bedroomController.text = propertyVM.bedroom.toString();
    _sittingroomController.text = propertyVM.sittingRoom.toString();
    _bathroomController.text = propertyVM.bathroom.toString();
    _toiletController.text = propertyVM.toilet.toString();
    _kitchenController.text = propertyVM.kitchen.toString();
  }


  @override
  Widget build(BuildContext context) {

    final propertyVM = ref.watch(propertyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        elevation: 0,
        backgroundColor: Colors.white24,
        foregroundColor: KColorScheme.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 28.r,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'CLEAR ALL',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.deepPurple, fontWeight: FontWeight.w600
              )
            ),
            onPressed: (){
              propertyVM.clearFilter();
              Navigator.pop(context);
            },
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
                      InputField("bed rooms", _bedroomController, validator: Validators.numberValidator),
                      InputField("Sitting rooms", _sittingroomController, validator: Validators.numberValidator),
                      InputField("Kitchen", _kitchenController, validator: Validators.numberValidator),
                      InputField("Bathrooms", _bathroomController, validator: Validators.numberValidator),
                      InputField("Toilet", _toiletController, validator: Validators.numberValidator),
                    ],
                  ),
                ),
              )
            ),
            RectRoundedButton(
              title: "Filter",
              isLoading: propertyVM.isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()){

                  propertyVM.bedroom = int.parse(_bedroomController.text);
                  propertyVM.sittingRoom = int.parse(_sittingroomController.text);
                  propertyVM.kitchen = int.parse(_kitchenController.text);
                  propertyVM.bathroom = int.parse(_bathroomController.text);
                  propertyVM.toilet = int.parse(_toiletController.text);

                  propertyVM.filterProperty();

                  Navigator.pop(context);
                }
              },
            )
          ],
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
