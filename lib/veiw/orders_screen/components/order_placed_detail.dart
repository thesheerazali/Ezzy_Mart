import 'package:my_mart/consts/consts.dart';

Widget orderPlacedDetail({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '$title1'.text.fontFamily(semibold).make(),
            '$d1'.text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              '$title2'.text.fontFamily(semibold).make(),
              '$d2'.text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
