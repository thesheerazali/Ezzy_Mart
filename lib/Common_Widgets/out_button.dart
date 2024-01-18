import 'package:my_mart/consts/consts.dart';

Widget ourButton({color, textColor, String? title, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
