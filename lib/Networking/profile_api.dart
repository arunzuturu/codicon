import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/codechef_model.dart';

class APIRepository{
  getProfileCodechef()async{
    var baseurl = "https://codec-api.herokuapp.com/user.info?handle=arun_adithya";
    var url = Uri.parse(baseurl);
    final response = await http.get(url);
    if(response.statusCode == 200 )
      {
        print(response.body);
        return CodechefModal.fromJson(jsonDecode(response.body));
      }
    else
      {
        throw Exception("Failed to load data");
      }
  }
}