part of 'sub_category_bloc.dart';

abstract class SubCategoryEvent extends Equatable {
  const SubCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetSubCategoriesByOtc extends SubCategoryEvent {
  final String otc;

  const GetSubCategoriesByOtc({required this.otc});
}
