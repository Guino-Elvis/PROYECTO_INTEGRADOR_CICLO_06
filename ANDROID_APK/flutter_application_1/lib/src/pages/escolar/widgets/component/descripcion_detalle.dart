import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index){
        return ListTile(
          leading: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow_rounded,
            color: Colors.white,size: 30,),
          ),
          title: Text('holaaaaaaaaaddddda'),
          subtitle:Text('haaaaaaaaaaaaaaa') ,
        );
      },
    );
  }
}