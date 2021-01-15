import 'package:flutter/material.dart';

class CustomPathClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      Path path = new Path();
    path.lineTo(0, size.height / 4.25);

    var firstControlPoint = new Offset(size.width / 4, size.height / 3);
    var firstEndPoint = new Offset(size.width / 2, size.height / 3 - 60);
   
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

        var secondControlPoint =
        new Offset(size.width - (size.width / 4), size.height / 4 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 3 - 40);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
  
    path.close();
    return path;
    }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
return false;
  }
  
}