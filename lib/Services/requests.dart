import 'package:http/http.dart' as http;
getUsers(){
  http.get("https://secure-temple-09752.herokuapp.com/").then((response) {
    if(response.statusCode == 200){
      print(response.body);
    }
  }).catchError((error){
    print(error);
  });
}