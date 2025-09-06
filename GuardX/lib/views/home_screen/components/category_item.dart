
import 'package:guardx/consts/index.dart';

/*
Widget categoryItem(Icon img, Color color, String title, String subTitle) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 9),
    height: 82,
    //width: 184,
    constraints: BoxConstraints(minWidth: 154, maxWidth: 284),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mainColor,
          ),
          child: img,
          alignment: Alignment.center,
        ),
        12.widthBox,
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //title.tr.text.color(darkFontGrey).fontFamily(regular).size(5).make(),
                  Text(
                    title,
                    style: TextStyle(
                        color: darkFontGrey, fontSize: 8, fontFamily: regular),
                  ),
                  Text(
                    "32 $subTitle",
                    style: TextStyle(
                        color: blackColor, fontSize: 10, fontFamily: semibold),
                  ), /*
                  "32 $subTitle"
                      .tr
                      .text
                      .size(10)
                      .color(blackColor)
                      .fontFamily(semibold)
                      .make(),*/
                ],
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: darkFontGrey, width: 0.8),
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 12,
                  color: darkFontGrey,
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
*/
Widget categoryItem2(
    Icon img, Color color, String title, String subTitle, String quantity) {
  return Container(
    height: 172,
    constraints: BoxConstraints(minWidth: 134, maxWidth: 284),
    //width: 184,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 28),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mainColor,
          ),
          alignment: Alignment.center,
          child: img,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //title.tr.text.color(darkFontGrey).fontFamily(regular).size(5).make(),
                  Text(
                    title,
                    style: TextStyle(
                        color: darkFontGrey, fontSize: 12, fontFamily: regular),
                  ),
                  Text(
                    "$quantity $subTitle",
                    style: TextStyle(
                        color: blackColor, fontSize: 14, fontFamily: semibold),
                  ),
                ],
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: darkFontGrey, width: 0.8),
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 12,
                  color: darkFontGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
/*
Widget categoryItem(String img, Color color,  title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(img),
            ),
          ),
          title,
        ],
      ),
    ),
  );
}*/