import 'package:Seller_App/Screens/loginScreen/components/passwordForm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Seller_App/Screens/loginScreen/components/emailForm.dart';
void main(){
  test("returns null if valid email is entered", (){
    var result=EmailFieldValidator.validate('laxmi@gmail.com');
    expect(result,null);
  });
  test("troughs error message if email is not valid",(){
    var result=EmailFieldValidator.validate('');
    String expectedResult="Email Id should be valid" ;
    expect(result,expectedResult);
  });
  test("returns null if password is entered", (){
    var result=PassWordFieldValidator.validator("1234");
    expect(result,null);
  });
  test("returns error message if password is not entered", (){
    var result=PassWordFieldValidator.validator("");
    String expected="Password can't be left empty";
    expect(result,expected);
  });
}