import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Seccion3Escolar extends StatelessWidget {
  const Seccion3Escolar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _buildTitleSection(),
          SizedBox(height: 50),
          _buildGridView(context),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
              _buildIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(left: 65),
      child: Column(
        children: [
          Text(
            "Courses",
            style: TextStyle(
              color: HexColor("#0e1b4d"),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 70.0,
            color: HexColor('#F82249'),
            height: 3.0,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.only(left: 50),
      child: InkWell(
        onTap: () {},
        child: Icon(Icons.abc_rounded),
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            (MediaQuery.of(context).size.height - 30 - 25) / (4 * 190),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder:(context) => DetalleEscolar()),
            );
          
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/lib1.jfif",
                    fit: BoxFit.cover,
                   width: 100,
                   height: 100,
                  ),
                ),
                Text(
                  'holaa',
                  style: TextStyle(
                    color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
