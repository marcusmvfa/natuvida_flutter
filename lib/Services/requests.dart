import 'package:flutter/material.dart';
import 'package:http/http.dart';

const BASEURL = "secure-temple-09752.herokuapp.com";

// get's
const GETPOSTAGENS = "/getPostagens";
const GETPOSTAGEMDETALHES = "/getPostagemDetalhes";
const GETMODULOS = "/getModulos";
const GETMODULOSDETALHES = "/getModuloDetalhes";
// post's
const POSTRESPOSTAS = "/postRespostas";

var url = Uri(scheme: "http", host: "secure-temple-09752.herokuapp.com");
// const BASEURL = "http://192.168.1.76:3000/";

getUsers() {
  get(url).then((response) {
    if (response.statusCode == 200) {
      // print(response.body);
    }
  }).catchError((error) {
    print(error);
  });
}

dynamic getPostagens() async {
  var s = url.resolve(BASEURL);
  var posts = await get(
    Uri(path: BASEURL + "/getPostagens"),
  ).then((response) {
    if (response.statusCode == 200) {
      return response.body;
    }
  }).catchError((error) {
    print(error);
  });
  return posts;
}

Future<Response?> getModulos() async {
  url = getUri(GETMODULOS);
  Response? posts = await get(url).then((response) {
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }).catchError((error) {
    print(error);
    return null;
  });
  return posts;
}

Future<Response> getPostagemDetalhes(String id) async {
  var url = Uri().resolve(BASEURL + "getPostagemDetalhes?id=" + id.toString());
  return await get(url).then((value) {
    var result = value;
    return result;
  });
}

///TODO: Ajustar método no back-end pra trazer os detalhes atualizados de cada usuário
Future<Response> getModulesDetails(idUsuario, idModulo) async {
  var url = getUri(GETMODULOSDETALHES, queryParameter: {"id": idModulo.toString()});
  return await get(url);
}

Future<Response> saveResposta(json) async {
  var url = getUri(POSTRESPOSTAS);
  return await post(url, body: json);
}

Uri getUri(path, {queryParameter}) {
  return new Uri(scheme: "https", host: BASEURL, path: path, queryParameters: queryParameter);
}
