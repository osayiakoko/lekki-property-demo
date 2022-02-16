import 'package:flutter/material.dart';

const List<String> monthsInYear = [
  'Jan', 
  'Feb', 
  'Mar', 
  'Apr', 
  'May', 
  'Jun', 
  'Jul', 
  'Aug', 
  'Sep', 
  'Oct', 
  'Nov', 
  'Dec', 
];

int getMonthNum(String month){
  return monthsInYear.indexOf(month.substring(0,3)) + 1;
}


DateTime parseDynamicDate(String jsonDateTime){
    DateTime parsedDateTime;

    try{
      parsedDateTime = DateTime.parse(jsonDateTime);
    }on Exception{
      /*
        handles Date not properly formatted as intl Date
        e.g "17 February 2022" or "2022-9-15" insted of "2022-01-01" 
      */
      
      // handles date sent as "2022-9-15"
      List<String> splittedDate = jsonDateTime.toString().split('-');

      if (splittedDate.length < 3){
        // handles date sent as "17 February 2022"
        splittedDate = jsonDateTime.split(' ');
        String temp = splittedDate[0];
        
        splittedDate[0] = splittedDate[2];
        splittedDate[1] = getMonthNum(splittedDate[2]).toString();
        splittedDate[2] = temp;
      }

      int year = int.parse(splittedDate[0]);
      int month = int.parse(splittedDate[1]);
      int day = int.parse(splittedDate[2]);

      parsedDateTime = DateTime(year, month, day);
    }

    return parsedDateTime;
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'good morning.';
  }
  if (hour < 17) {
    return 'good afternoon.';
  }
  return 'good evening.';
}


BorderRadius getRadius([full = false]){
  return full 
    ? BorderRadius.circular(8) 
    : const BorderRadius.only(
        topLeft: Radius.circular(8), topRight: Radius.circular(8)
      );
}