
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';
import 'package:guardx/controllers/home_controller.dart'; 
import 'package:guardx/widgets/big_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: navBarBody.isNotEmpty
                  ? navBarBody.elementAt(controller.navBarIndex.value)
                  : Center(child: BigText(text: "No Content")),
            ),
          )
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedLabelStyle:
              TextStyle(color: whiteColor, fontSize: 10, fontFamily: medium),
          selectedLabelStyle:
              TextStyle(color: whiteColor, fontSize: 10, fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          items: navBarItems,
          currentIndex: controller.navBarIndex.value,
          onTap: (index) {
            //if (index != 2) {
            controller.navBarIndex.value = index;
            //}
          },
           
          selectedIconTheme: IconThemeData(color: Color(0xFF0029E0),),
          selectedItemColor: Color(0xFF0029E0),
          showUnselectedLabels: true,
        ),
      ), 
    );
  }
}
