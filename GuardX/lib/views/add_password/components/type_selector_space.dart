import 'package:guardx/consts/index.dart';
import 'package:guardx/views/add_password/components/type_selector_button.dart';

Widget accountTypeSpace() {
  print("Length of accountTypeData: ${accountTypeData.length}");

  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: socialmediaAccountType(
          socialMediaData: accountTypeData,
        ),
      ),
    ]),
  );
}

Widget documentTypeSpace() {
  return SingleChildScrollView(
    //padding: const EdgeInsets.all(3),
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        documentTypeList.length,
        (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: cardDocumentTypeSelectorButton(documentTypeList[index])),
      ),
    ),
  );
}

Widget cardTypeSpace() {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        cardTypeList.length,
        (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: cardDocumentTypeSelectorButton(cardTypeList[index])),
      ),
    ),
  );
}
