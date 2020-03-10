import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class SlidePickerColor extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;

  SlidePickerColor({Key key, @required this.color, @required this.onChanged})
      : assert(color != null),
        super(key: key);

  @override
  SlidePickerColorState createState() => new SlidePickerColorState();
}

class SlidePickerColorState extends State<SlidePickerColor> {
  HSVColor get color => super.widget.color;

  //Hue
  void hueOnChange(double value) =>
      super.widget.onChanged(this.color.withHue(value));
  List<Color> get hueColors => [
        this.color.withHue(0.0).toColor(),
        this.color.withHue(60.0).toColor(),
        this.color.withHue(120.0).toColor(),
        this.color.withHue(180.0).toColor(),
        this.color.withHue(240.0).toColor(),
        this.color.withHue(300.0).toColor(),
        this.color.withHue(0.0).toColor()
      ];

  //Saturation Value
  void saturationValueOnChange(Offset value) => super.widget.onChanged(
      HSVColor.fromAHSV(this.color.alpha, this.color.hue, value.dx, value.dy));
  //Saturation
  List<Color> get saturationColors => [
        Colors.white,
        HSVColor.fromAHSV(1.0, this.color.hue, 1.0, 1.0).toColor()
      ];
  //Value
  final List<Color> valueColors = [Colors.transparent, Colors.black];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      //Slider
      new SliderPicker(
        min: 0.0,
        max: 360.0,
        value: this.color.hue,
        onChanged: this.hueOnChange,
        colors: this.hueColors,
      )
    ]);
  }
}
