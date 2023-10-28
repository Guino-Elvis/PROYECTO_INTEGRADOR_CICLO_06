import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/appbar_escolar_detalle.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/descripcion_detalle.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/video_escolar_detalle.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class DetalleEscolar extends StatefulWidget {
  const DetalleEscolar({Key? key}) : super(key: key);

  @override
  State<DetalleEscolar> createState() => _DetalleEscolarState();
}

class _DetalleEscolarState extends State<DetalleEscolar> {
  bool isVideosSection= true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppbarEscolarDetalle(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage("assets/curso1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#0e1b4d")
                            .withOpacity(0.6), // Color verde con opacidad
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Espacio entre la imagen y el texto
                Text(
                  "Complerte sss",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#0e1b4d"),
                  ),
                ),
                Text(
                  "Creasion de todoooo",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "55 Videos",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        //if isVideosSection is true and else
                         color: isVideosSection? HexColor("#0e1b4d") : HexColor("#0e1b4d").withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isVideosSection = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 35),
                            child: Text(
                              'videos',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(width: 20),
                      Material(
                         color: isVideosSection? HexColor("#0e1b4d").withOpacity(0.6) : HexColor("#0e1b4d"),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                              setState(() {
                              isVideosSection = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 35),
                            child: Text(
                              'ddddddddd',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                isVideosSection? VideosSection() : DescriptionSection(),
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
