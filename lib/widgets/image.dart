import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget{
  
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _ImageInputState();
    }

}

class _ImageInputState extends State<ImageInput>{

    void _openImagePicker(BuildContext context){
      showModalBottomSheet(context:  context, builder: (BuildContext context){
        return Container(
          height: 160.0,
          padding: EdgeInsets.all(
          10.0), child: Column(
            children: <Widget>[
              Text('Pick a image'),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(child: Text('Use camera'), onPressed: (){},),
               SizedBox(
                height: 5.0,
              ),
               FlatButton(child: Text('Use gallery'), onPressed: (){},),
            ],
          ),
        );
      });
    }

    @override
      Widget build(BuildContext context) {
        // TODO: implement build
        return Column(children: <Widget>[
          OutlineButton(
            onPressed: (){_openImagePicker(context);},
            child: Row(
            children: <Widget>[
              Icon(Icons.camera_alt),
              Text('Add image')
            ],
          ),)
        ],);
      }
}