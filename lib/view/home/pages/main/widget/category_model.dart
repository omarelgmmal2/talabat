import '../../../../../core/utils/assets.dart';

class CategoryModel {
  final String img, name;

  CategoryModel({
    required this.img,
    required this.name,
  });
}

List<CategoryModel> categoryList = [
  CategoryModel(
    img: AssetsData.mobiles,
    name: "Phones",
  ),
  CategoryModel(
    img: AssetsData.pc,
    name: "Laptops",
  ),
  CategoryModel(
    img: AssetsData.electronics,
    name: "Electronics",
  ),
  CategoryModel(
    img: AssetsData.watch,
    name: "Watches",
  ),
  CategoryModel(
    img: AssetsData.fashion,
    name: "Clothes",
  ),
  CategoryModel(
    img: AssetsData.shoes,
    name: "Shoes",
  ),
  CategoryModel(
    img: AssetsData.book,
    name: "Books",
  ),
  CategoryModel(
    img: AssetsData.cosmetics,
    name: "Cosmetics",
  ),
];
