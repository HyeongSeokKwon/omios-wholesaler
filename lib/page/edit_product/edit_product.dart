import 'package:deepy_wholesaler/page/regist_product/regist_product.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';

class EditProduct extends StatefulWidget {
  final int productId;
  const EditProduct({required this.productId, Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitEditItemBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
          ),
        ),
        body: ScrollArea(productId: widget.productId),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}

class ScrollArea extends StatelessWidget {
  final int productId;
  const ScrollArea({required this.productId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitEditItemBloc, InitEditItemState>(
      builder: (context, state) {
        if (state.fetchState == FetchState.success) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ImageArea(),
                    const InfoArea(),
                    SizedBox(height: 30 * Scale.height),
                    const EditButtonArea(),
                  ]),
            ),
          );
        } else if (state.fetchState == FetchState.loading) {
          return progressBar();
        } else {
          BlocProvider.of<InitEditItemBloc>(context)
              .add(LoadEditProductDataEvent(productId: productId));
          return Container();
        }
      },
    );
  }
}

class ImageArea extends StatelessWidget {
  const ImageArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 414 * Scale.width,
      height: 400 * Scale.height,
    );
  }
}

class InfoArea extends StatelessWidget {
  const InfoArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitEditItemBloc, InitEditItemState>(
      builder: (context, state) {
        return SizedBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${state.data['name']}",
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 20.0),
            ),
            Text(
              "${state.data['id']}",
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 20.0),
            ),
            Text(
              "${state.data['price']}",
              style:
                  textStyle(Colors.black, FontWeight.w400, "NotoSansKR", 20.0),
            )
          ],
        ));
      },
    );
  }
}

class EditButtonArea extends StatelessWidget {
  const EditButtonArea({Key? key}) : super(key: key);
  static const edit = "수정";
  static const delete = "삭제";
  static const soldOut = "품절";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(edit,
                  style: textStyle(
                      Colors.black, FontWeight.w500, "NotoSansKR", 14.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(110 * Scale.width, 60 * Scale.height)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                final initEditItemBloc =
                    BlocProvider.of<InitEditItemBloc>(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistProduct(
                        registMode: RegistMode.edit,
                        initEditItemBloc: initEditItemBloc),
                  ),
                );
              },
            ),
            SizedBox(
              width: 12 * Scale.width,
            ),
            TextButton(
              child: Text(soldOut,
                  style: textStyle(
                      Colors.black, FontWeight.w500, "NotoSansKR", 14.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(110 * Scale.width, 60 * Scale.height)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {},
            ),
            SizedBox(
              width: 12 * Scale.width,
            ),
            TextButton(
              child: Text(delete,
                  style: textStyle(
                      Colors.black, FontWeight.w500, "NotoSansKR", 14.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(110 * Scale.width, 60 * Scale.height)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {},
            ),
          ],
        ),
        SizedBox(
          height: 15 * Scale.height,
        ),
        TextButton(
          child: Text("당일발송가능 재고",
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 14.0)),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
                Size(354 * Scale.width, 60 * Scale.height)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () async {},
        ),
      ],
    ));
  }
}
