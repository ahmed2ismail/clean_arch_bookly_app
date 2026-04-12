import 'package:clean_arch_bookly_app/Features/home/data/models/books_model/list_price.dart';

class SaleInfo {
  String? country;
  String? saleability;
  bool? isEbook;
  String? buyLink;
  final ListPrice? listPrice;

  SaleInfo({this.country, this.saleability, this.isEbook, this.buyLink, this.listPrice});

  factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
    country: json['country'] as String?,
    saleability: json['saleability'] as String?,
    isEbook: json['isEbook'] as bool?,
    buyLink: json['buyLink'] as String?,
    listPrice: json['listPrice'] == null
            ? null
            : ListPrice.fromJson(json['listPrice'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'country': country,
    'saleability': saleability,
    'isEbook': isEbook,
    'buyLink': buyLink,
    'listPrice': listPrice?.toJson(),
  };
}
