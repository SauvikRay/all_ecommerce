import 'package:skybuybd/models/home/announcement_model.dart';
import 'package:skybuybd/models/home/recent_product_model.dart';
import 'package:skybuybd/models/home/top_cat_product_model.dart';
import 'package:skybuybd/models/home/top_cats_model.dart';

import 'banner_model.dart';


class HomeModel {
  AnnouncementModel? announcement;
  List<TopCatModel>? top_cats;
  List<BannerModel>? banners;
  RecentProductModel? recentProductModel;
  List<TopCategoryProductModel>? shoes;
  List<TopCategoryProductModel>? bag;
  List<TopCategoryProductModel>? jewelry;
  List<TopCategoryProductModel>? baby;
  List<TopCategoryProductModel>? watch;

  HomeModel({
    this.announcement,
    this.top_cats,
    this.banners,
    this.recentProductModel,
    this.shoes,
    this.bag,
    this.jewelry,
    this.baby,
    this.watch
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    announcement = json['announcement'];
    if (json['top_cats'] != null) {
      top_cats = <TopCatModel>[];
      json['top_cats'].forEach((v) {
        top_cats!.add(TopCatModel.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <BannerModel>[];
      json['banners'].forEach((v) {
        banners!.add(BannerModel.fromJson(v));
      });
    }
    recentProductModel = json['recentProducts'];
    if (json['shoes'] != null) {
      shoes = <TopCategoryProductModel>[];
      json['shoes'].forEach((v) {
        shoes!.add(TopCategoryProductModel.fromJson(v));
      });
    }
    if (json['bag'] != null) {
      bag = <TopCategoryProductModel>[];
      json['bag'].forEach((v) {
        bag!.add(TopCategoryProductModel.fromJson(v));
      });
    }
    if (json['jewelry'] != null) {
      jewelry = <TopCategoryProductModel>[];
      json['jewelry'].forEach((v) {
        jewelry!.add(TopCategoryProductModel.fromJson(v));
      });
    }
    if (json['baby'] != null) {
      baby = <TopCategoryProductModel>[];
      json['baby'].forEach((v) {
        baby!.add(TopCategoryProductModel.fromJson(v));
      });
    }
    if (json['watch'] != null) {
      watch = <TopCategoryProductModel>[];
      json['watch'].forEach((v) {
        watch!.add(TopCategoryProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['announcement'] = this.announcement;
    if (this.top_cats != null) {
      data['top_cats'] = this.top_cats!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    data['recentProducts'] = this.recentProductModel;
    if (this.shoes != null) {
      data['shoes'] = this.shoes!.map((v) => v.toJson()).toList();
    }
    if (this.bag != null) {
      data['bag'] = this.bag!.map((v) => v.toJson()).toList();
    }
    if (this.jewelry != null) {
      data['jewelry'] = this.jewelry!.map((v) => v.toJson()).toList();
    }
    if (this.baby != null) {
      data['baby'] = this.baby!.map((v) => v.toJson()).toList();
    }
    if (this.watch != null) {
      data['watch'] = this.watch!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}