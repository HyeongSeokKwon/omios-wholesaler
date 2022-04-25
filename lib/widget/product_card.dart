import 'package:cached_network_image/cached_network_image.dart';
import 'package:deepy_wholesaler/model/product_model.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double imageWidth;

  const ProductCard({Key? key, required this.product, required this.imageWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
      },
      child: Column(
        children: [
          _buildProductImage(),
          _buildProductInfo(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            width: imageWidth,
            height: imageWidth * (4 / 3),
            fit: BoxFit.fill,
            imageUrl: product.mainImage,
            fadeInDuration: const Duration(milliseconds: 0),
            placeholder: (context, url) {
              return Container(
                  color: Colors.grey[200],
                  width: imageWidth,
                  height: imageWidth * (4 / 3));
            },
          )),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return SizedBox(
      width: imageWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12 * Scale.height),
          Text(
            product.name,
            style: textStyle(
                const Color(0xff999999), FontWeight.w400, "NotoSansKR", 12.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4 * Scale.height),
          Text(
            setNumberFormat(product.price) + '원',
            style: textStyle(
                const Color(0xff333333), FontWeight.w700, "NotoSansKR", 15.0),
          ),
          SizedBox(height: 4 * Scale.height),
        ],
      ),
    );
  }
}
