import 'package:http/http.dart' as http;
const BASEURL = "https://secure-temple-09752.herokuapp.com/";
// const BASEURL = "http://192.168.1.76:3000/";

getUsers() {
  http.get("https://secure-temple-09752.herokuapp.com/").then((response) {
    if (response.statusCode == 200) {
      // print(response.body);
    }
  }).catchError((error) {
    print(error);
  });
}

dynamic getPostagens() async {
  var posts = await http
      .get("https://secure-temple-09752.herokuapp.com/getPostagens")
      .then((response) {
    if (response.statusCode == 200) {
      return response.body;
    }
  }).catchError((error) {
    print(error);
  });
  return posts;
}

getModulos() async {
  var posts =
      await http.get(BASEURL + "getModulos").then((response) {
    if (response.statusCode == 200) {
      return response.body;
    }
  }).catchError((error) {
    print(error);
  });
  return posts;
}

getPostagemDetalhes(String id) async {
  return await http.get(
      // "https://secure-temple-09752.herokuapp.com/getPostagemDetalhes?id=" +
      BASEURL + "getPostagemDetalhes?id=" + id.toString());
}

Future getModulesDetails(idUsuario, idModulo) async {
  return await http
        .get(BASEURL + "getModuloDetalhes?idUsuario=" +
             idUsuario.toString()+ "&idModulo=" + idModulo.toString());
}
