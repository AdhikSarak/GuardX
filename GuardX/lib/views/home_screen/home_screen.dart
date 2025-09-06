import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/home_controller.dart';
import 'package:guardx/views/home_screen/components/category_space.dart';
import 'package:guardx/utils/widgets/search_bar.dart';
import 'package:guardx/views/home_screen/components/added_passwords_space.dart';
import 'package:guardx/views/home_screen/components/slide_space.dart';
import 'package:guardx/views/home_screen/components/user_space.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ExpandableFabState> fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(11),
        width: context.screenWidth,
        height: context.screenHeight,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userSpace(),
                20.heightBox,
                searchBar(searchHere.tr, context),
                20.heightBox,
                slideSpace(),
                20.heightBox,
                categorySpace(context),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: savedPasswords.tr.text
                            .size(16)
                            .color(whiteColor)
                            .fontFamily(bold)
                            .make()),
                    //sortBy.tr.text.size(20).bold.make(),
                    DropdownButton(
                      //isDense: false,
                      value: sortByDropdownItems[
                              controller.passwordListIndex.value]
                          .value,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      borderRadius: BorderRadius.circular(20),
                      items: sortByDropdownItems,
                      onChanged: (newvalue) {
                        setState(() {});
                        print(controller.passwordListIndex.value);
                        controller.passwordListIndex.value =
                            int.parse(newvalue.toString());
                      },
                      hint:
                          "${sortByDropdownItems[controller.passwordListIndex.value].value}"
                              .text
                              .size(12)
                              .color(whiteColor)
                              .fontFamily(medium)
                              .make(),
                      elevation: 8,
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      iconEnabledColor: whiteColor,
                      underline: const SizedBox(),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                15.heightBox,
                addedPasswordsSpace(context),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: ExpandableFab(
            key: fabKey,
            distance: 75,
            fanAngle: 75,
            overlayStyle: ExpandableFabOverlayStyle(
                color: Colors.white.withOpacity(0.1), blur: 2.5),
            closeButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(
                Icons.close_rounded,
                size: 40,
              ),
              fabSize: ExpandableFabSize.regular,
              //foregroundColor: Colors.amber,
              backgroundColor: mainColor,
              shape: const CircleBorder(
                  side: BorderSide(color: whiteColor, width: 1.5)),
              angle: 3.14 * 2,
            ),
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(
                Icons.add_rounded,
                size: 40,
                color: whiteColor,
                weight: 0.5,
              ),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: mainColor,
              backgroundColor: mainColor,
              shape: const CircleBorder(
                  side: BorderSide(color: whiteColor, width: 1.5)),
              angle: 3.14 / 2,
            ),
            type: ExpandableFabType.fan,
            pos: ExpandableFabPos.right,
            children: [
              FloatingActionButton(
                onPressed: () {
                  fabKey.currentState?.toggle();
                  Future.delayed(Duration(milliseconds: 200), () {
                    Get.toNamed('/addPasswordScreen');
                  });
                },
                heroTag: Text('passwords'),
                hoverColor: pinkColor.withOpacity(0.1),
                shape: const CircleBorder(),
                backgroundColor: lightGrey,
                child: const Icon(
                  Icons.key,
                  size: 22,
                  color: pinkColor,
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  fabKey.currentState?.toggle(); // Step 3: Close FAB
                  Future.delayed(Duration(milliseconds: 200), () {
                    Get.toNamed('/addCardScreen'); // Step 4: Navigate
                  });
                },
                heroTag: Text('Cards'),
                shape: const CircleBorder(),
                backgroundColor: lightGrey,
                child: const Icon(
                  Icons.credit_card,
                  size: 22,
                  color: pinkColor,
                ),
              ),
             
            ]),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
    );
  }
}
