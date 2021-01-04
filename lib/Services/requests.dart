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
dynamic getPostagens() async {
  var posts = await http.get("https://secure-temple-09752.herokuapp.com/getPostagens").then((response) {
    if(response.statusCode == 200){
      return response.body;
    }
  }).catchError((error){
    print(error);
  });
  return posts;
}