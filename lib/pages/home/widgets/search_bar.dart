import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/route/route_helper.dart';
import 'package:skybuybd/utils/app_colors.dart';
import 'package:skybuybd/utils/dimentions.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final textFieldFocusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10, vertical: Dimensions.height10),
      child: SizedBox(
        height: Dimensions.height45,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(Dimensions.radius20 / 2),
            prefixIcon: GestureDetector(
              onTap: () {
                // _showPicker(context);
              },
              child: const Icon(
                Icons.camera_alt_rounded,
                color: AppColors.btnColorBlueDark,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                //Text Search
                textFieldFocusNode.unfocus();
                textFieldFocusNode.canRequestFocus = false;

                String keyword = controller.text;
                if (keyword.isEmpty) {
                  showCustomSnakebar("Search keyword is empty!",
                      isError: false, title: "Search Error");
                } else {
                  Get.toNamed(
                      RouteHelper.getSearchPage(keyword, "keyword", ""));
                }

                //Enable the text field's focus node request after some delay
                Future.delayed(const Duration(milliseconds: 100), () {
                  textFieldFocusNode.canRequestFocus = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius8),
                    bottomRight: Radius.circular(Dimensions.radius8),
                  ),
                  color: AppColors.btnColorBlueDark,
                ),
                child: const Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search by keyword',
            hintMaxLines: 1,
          ),
        ),
      ),
    );
  }
}
