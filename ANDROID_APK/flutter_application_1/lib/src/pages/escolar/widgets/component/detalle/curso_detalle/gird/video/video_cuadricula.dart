import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class GridViewEscolarDetalleVideo extends StatefulWidget {
  const GridViewEscolarDetalleVideo({super.key});

  @override
  State<GridViewEscolarDetalleVideo> createState() =>
      _GridViewEscolarDetalleVideoState();
}

class _GridViewEscolarDetalleVideoState
    extends State<GridViewEscolarDetalleVideo> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 4.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: Colors.white,
                // border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      child: Image.asset(
                        "assets/curso3.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(
                                        90), // Ajusta el radio según lo necesites
                                  ),
                                  padding: EdgeInsets.all(0.1),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.red,
                                    size: 45,
                                  ),
                                ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        color: HexColor("#080C1E").withOpacity(0.9),
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Text(
                              '27 de octubre',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
