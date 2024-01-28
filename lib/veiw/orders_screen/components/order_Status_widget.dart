import 'package:my_mart/consts/consts.dart';

Widget orderStatus({icon, title, color, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      // height: 50,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
