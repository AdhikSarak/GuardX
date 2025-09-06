import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:guardx/consts/colors.dart';
import 'package:guardx/widgets/big_text.dart';
import 'package:guardx/widgets/custom_elevated_button.dart';
import 'package:guardx/widgets/small_text.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String searchQuery = "";

  // List of FAQ titles and descriptions
  final List<Map<String, String>> faqList = [
    {
      "title": "What is GuardX",
      "description":
          "Lorem ipsum dolor sit amet consectetur. Odio tellus imperdiet nibh gravida dui habitant montes. Egestas nulla est nisi dignissim ac aliquam tellus pretium urna."
    },
    {
      "title": "How to use GuardX",
      "description":
          "GuardX is a simple to use app that allows you to manage your security settings effortlessly."
    },
    // Add more FAQ items here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                    color: AppColor.whiteColor,
                  ),
        title: const Text(
          "Help",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SmallText(
                text:
                    '''We’re here to help and support you with anything and everything on GuardX''',
                color: AppColor.whiteColor,
                size: 16,
              ),
              const SizedBox(height: 10),
              // SEARCH FIELD
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search help...",
                  hintStyle: const TextStyle(color: Colors.white24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: AppColor.whiteColor,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColor.whiteColor)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              // Filtered FAQ items based on search query
              Column(
                children: faqList
                    .where((faq) =>
                        faq["title"]!.toLowerCase().contains(searchQuery))
                    .map((faq) => CustomContainer(
                          title: faq["title"]!,
                          description: faq["description"]!,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 30),
              const CustomElevatedButton(
                text: 'Send a message',
                backgroundColor: AppColor.mainColor,
                borderColor: AppColor.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;

  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ExpandablePanel(
            header: Padding(
                padding: const EdgeInsets.all(5.0),
                child: BigText(
                  text: title,
                  size: 16,
                  color: AppColor.whiteColor,
                  weight: FontWeight.w600,
                )),
            collapsed: const SizedBox.shrink(),
            expanded: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 4, 0),
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ),
            hasIcon: true,
            expandIcon: Icons.add,
          ),
        ),
      ),
    );
  }
}

class ExpandablePanel extends StatefulWidget {
  final Widget header;
  final Widget collapsed;
  final Widget expanded;
  final bool hasIcon;
  final IconData expandIcon;

  const ExpandablePanel({
    required this.header,
    required this.collapsed,
    required this.expanded,
    this.hasIcon = true,
    this.expandIcon = Icons.keyboard_arrow_down,
    super.key,
  });

  @override
  _ExpandablePanelState createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.header,
              if (widget.hasIcon)
                Icon(
                  _isExpanded ? Icons.close : widget.expandIcon,
                ),
            ],
          ),
        ),
        if (_isExpanded) widget.expanded else widget.collapsed,
      ],
    );
  }
}
