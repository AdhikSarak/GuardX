 
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart'; 
import 'package:guardx/controllers/language_controller.dart';

Future<dynamic> selectLanguage(context) {
  var languageController = Get.put(LanguageController());
  return showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.9,
      useSafeArea: true,
      showDragHandle: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close)),
                  20.widthBox,
                  appLanguage.tr.text.size(20).make(),
                ],
              ),
              10.heightBox,              
              const Divider(color: lightGrey, thickness: 2,),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
                        title: languageList[index],
                        onTap: () {

                          var values = languageList[index].value!.split("_");
                          languageController.changeLanguage(
                              values[0], values[1]);
                              
                          Get.back();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: languageList.length),
              )
            ],
          ),
        );
      });
}
