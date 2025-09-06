import 'package:guardx/consts/index.dart';

Widget slideSpace() {
  return VxSwiper.builder(
      autoPlay: false,
      viewportFraction: 1.0,
      //aspectRatio: 16 / 9,
      height: 120,
      enlargeCenterPage: true,
      itemCount: sliderList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: mainColor,
          ),
          child: Row(
            children: [
              Image.asset(
                sliderImageList[index],
                fit: BoxFit.fill,
              )
                  .box
                  .rounded
                  .clip(Clip.antiAlias)
                  .margin(const EdgeInsets.symmetric(horizontal: 8))
                  .make(),
                  Expanded(child: sliderList[index].text.size(16).color(whiteColor).fontFamily(bold).make()),
            ],
          ),
        );
      });
}
