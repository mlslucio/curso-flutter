import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget{
  
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _ImageInputState();
    }

}

class _ImageInputState extends State<ImageInput>{

  File _imageFile = null;

  void _getImage(BuildContext context,  ImageSource source) async {
    ImagePicker.pickImage(source: source, maxWidth: 400.0)
    .then((File image){
      setState(() {
        this._imageFile = image;       
      });
      Navigator.pop(context);
    });
  }

    void _openImagePicker(BuildContext context){
      showModalBottomSheet(context:  context, builder: (BuildContext context){
        return Container(
          height: 160.0,
          padding: EdgeInsets.all(
          10.0), child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              FlatButton(child: Text('Use camera'), onPressed: (){
                _getImage(context, ImageSource.camera);
              },),
               SizedBox(
                height: 5.0,
              ),
               FlatButton(child: Text('Use gallery'), onPressed: (){
                 _getImage(context, ImageSource.gallery);
               },),
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
            ],
          ),),
          SizedBox(height: 10.0,),
          this._imageFile == null? Text("") : Image.file(this._imageFile, fit:BoxFit.cover, 
          height: 300.0, alignment: Alignment.topCenter, width: MediaQuery.of(context).size.width)
        ],);
      }
}