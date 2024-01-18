import 'dart:convert';

import 'package:flutter_restfull/member.dart';
import 'package:http/http.dart';

class ApiService{
  final String apiUrl = "http://gdnexam.somee.com/api/members";

  Future<List<member>> getMember() async{
    Response res = await get(Uri.parse(apiUrl));
  
    if (res.statusCode==200) {
      List<dynamic> body = jsonDecode(res.body);
      List<member> members = body.map((e) => member.fromJson(e)).toList();
      print(members);
      return members;
    } else{
      throw "Failed to load members";
    }

  }

  Future<member> createMember (member _member)async{
    Map data = {
      'm_id':_member.m_id,
      'm_name':_member.m_name,
      'm_batch':_member.m_batch
    };

    final Response response = await post(
      Uri.parse(apiUrl),
      headers:  <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return member.fromJson(json.decode(response.body));
    }else{
      throw Exception("Fail to create member");
    }

  }

}