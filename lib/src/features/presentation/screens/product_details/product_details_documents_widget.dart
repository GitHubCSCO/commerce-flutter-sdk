import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/product_detail_documents_name_value_converter.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_documents_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsDocumentsWidget extends StatelessWidget {
  final ProductDetailsDocumentsEntity productdetailsdocumentsEntity;

  const ProductDetailsDocumentsWidget({
    super.key,
    required this.productdetailsdocumentsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              title: Text(
                productdetailsdocumentsEntity.title ?? "",
                style: OptiTextStyles.titleSmall,
              ),
              collapsedBackgroundColor: Colors.white,
              children: <Widget>[
                SizedBox(
                  height: productdetailsdocumentsEntity.documents!.length *
                      50.0, // Set a specific height for the ListView
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: OptiAppColors
                            .backgroundGray, // Customize the color of the divider
                        thickness: 2, // Customize the thickness of the divider
                      );
                    },
                    itemCount: productdetailsdocumentsEntity.documents!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            _launchURL(
                                productdetailsdocumentsEntity
                                    .documentPaths[index],
                                context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 0.0, 10.0),
                            child: Text(
                              productdetailsdocumentsEntity.documents?[index]
                                      .getDocumentDisplayName() ??
                                  '$index',
                              style: OptiTextStyles.body,
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, .0),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url, BuildContext context) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        CustomSnackBar.showSnackBarMessage(
          context,
          'Could not launch $url',
        );
      }
    }
  }
}
