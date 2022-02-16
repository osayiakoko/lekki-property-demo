
class Validators {
  static String? numberValidator(String? value){
    if (value != null){
      if (value.trim().isEmpty){
        return "Field is required";
      }

      if(num.tryParse(value) == null){
        return "invalid numeric input";
      }
    }
  }

  static String? validateIsEmpty(String? value) {
    if (value != null) {
      if (value.trim().isEmpty) {
        return 'Field is required';
      }
      return null;
    }
  }

}