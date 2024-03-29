import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mlr_app/Models/codeforces_model.dart';
import 'package:mlr_app/Models/leetcode_model.dart';
import '../Models/codechef_model.dart';

class APIRepository{
  // getProfileCodechef(String username)async{
  //   var baseurl = "https://codec-api.herokuapp.com/user.info?handle=$username";
  //   var url = Uri.parse(baseurl);
  //   final response = await http.get(url);
  //   if(response.statusCode == 200 )
  //     {
  //       return CodechefModal.fromJson(jsonDecode(response.body));
  //     }
  //   else
  //     {
  //       throw Exception("Failed to load data");
  //     }
  // }
  getProfileCodeforces(String username)async{
    var baseurl = "https://codeforces.com/api/user.info?handles=$username";
    var url = Uri.parse(baseurl);
    final response = await http.get(url);
    if(response.statusCode == 200 )
    {
      return CodeforcesModal.fromJson(jsonDecode(response.body));
    }
    else
    {
      throw Exception("Failed to load data");
    }
  }
  getProfileLeetCode(String username)async{
    var baseurl = "https://leetcode-stats-api.herokuapp.com/$username";
    var url = Uri.parse(baseurl);
    final response = await http.get(url);
    if(response.statusCode == 200 )
    {
      return LeetCodeModel.fromJson(jsonDecode(response.body));
    }
    else
    {
      throw Exception("Failed to load data");
    }
  }
}