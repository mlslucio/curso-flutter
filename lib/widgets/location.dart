import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class LocationMap extends StatefulWidget{

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _LocationState();
    }
}
class _LocationState extends State<LocationMap>{

  final FocusNode _adressInputFocusNode = FocusNode();
  
  @override
    void initState() {
      _adressInputFocusNode.addListener(_updateLocation);
      super.initState();
    }

  @override
    void dispose() {
      _adressInputFocusNode.removeListener(_updateLocation);
      super.dispose();
    }

  void _updateLocation(){

  }

  void getStaticMap() async {
    final StaticMapProvider staticMapViewProvider = StaticMapProvider('AIzaSyDl9CeHLtsg3euq2pAPPM-Fmg30wcG8orU');
    
    final Uri staticMapURI = staticMapViewProvider.getStaticUriWithMarkers([
      Marker('position','Position', 41.40332, 1.238493)
    ], center: Location(41.40332,  1.238493), width: 500, height:300, maptype: StaticMapViewType.roadmap );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Column(children: <Widget>[
        TextFormField(
          focusNode: _adressInputFocusNode,
        ),
        SizedBox(height: 10.0,),
        Image.network();
      ],);
    }
}