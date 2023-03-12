import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skybuybd/apps/categories/presentation/blocs/category/category_bloc.dart';
import 'package:skybuybd/apps/categories/presentation/blocs/sub_category_bloc/sub_category_bloc.dart';
import 'package:skybuybd/apps/core/di.dart';
import 'package:skybuybd/base/show_custom_snakebar.dart';
import 'package:skybuybd/models/category/category_model.dart';
import 'package:skybuybd/models/category/sub_category_model.dart';
import 'package:skybuybd/pages/home/widgets/Txt.dart';
import 'package:skybuybd/route/route_helper.dart';
import 'package:skybuybd/utils/constants.dart';
import 'package:skybuybd/utils/dimentions.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryBloc = injector<CategoryBloc>();
    return Drawer(
      child: BlocProvider.value(
        value: categoryBloc,
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CategorySuccess) {
              return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      cat: state.categories[index],
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.cat,
  }) : super(key: key);

  final CategoryModel cat;

  @override
  Widget build(BuildContext context) {
    final subCategoryBloc = injector<SubCategoryBloc>();

    return BlocProvider.value(
      value: subCategoryBloc,
      child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
        builder: (context, state) {
          return ExpansionTile(
            onExpansionChanged: (z) {
              if (z == true) {
                // Call to subcategories
                subCategoryBloc.add(
                  GetSubCategoriesByOtc(
                    otc: cat.otcId ?? '',
                  ),
                );
              }
            },
            leading: CachedNetworkImage(
              imageUrl: "${Constants.BASE_URL}/${cat.icon}",
              height: Dimensions.height30,
              width: Dimensions.width30,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Row(
              children: [
                Txt(
                  text: cat.name,
                  color: Colors.black,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            children: state is SubCategoryByOtcSuccess
                ? state.subCategories.map((subMenu) {
                    return SubCategoryTile(
                      subCategoryModel: subMenu,
                      cat: cat,
                    );
                  }).toList()
                : [].map((subMenu) {
                    return Container();
                  }).toList(),
          );
        },
      ),
    );
  }
}

class SubCategoryTile extends StatelessWidget {
  const SubCategoryTile({
    Key? key,
    required this.subCategoryModel,
    required this.cat,
  }) : super(key: key);

  final SubCategoryModel subCategoryModel;
  final CategoryModel cat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getCategoryProductPage(cat.name ?? '',
            subCategoryModel.name ?? '', "", subCategoryModel.otcId ?? ''));
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(
          left: Dimensions.width8 * 2,
          right: Dimensions.width8 * 3,
          top: Dimensions.height8,
          bottom: Dimensions.width8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Txt(
                text: subCategoryModel.name,
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                maxLines: 2,
                useoverflow: true,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
