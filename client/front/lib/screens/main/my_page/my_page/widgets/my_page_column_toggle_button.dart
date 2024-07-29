import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColumnToggleButton extends StatefulWidget {
  final bool initialToggleValue;
  final ValueChanged<bool>? onToggleChanged;

  const ColumnToggleButton({
    Key? key,
    this.initialToggleValue = false, // 기본 토글 on, off 상태
    this.onToggleChanged,
  }) : super(key: key);

  @override
  _ColumnToggleButtonState createState() => _ColumnToggleButtonState();
}

class _ColumnToggleButtonState extends State<ColumnToggleButton> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.initialToggleValue;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
          if (widget.onToggleChanged != null) {
            widget.onToggleChanged!(value);
          }
        },
        activeColor: Color(0xff7C3D1A),
        trackColor: Color(0xffD4D6DD),
      ),
    );
  }
}