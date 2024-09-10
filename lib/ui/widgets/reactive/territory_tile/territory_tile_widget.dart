import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/widgets/dumb_widgets/busy_widget.dart';
import 'package:distributor/ui/widgets/reactive/territory_tile/territory_tile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class TerritoryTileWidget extends StatelessWidget {
  final Fence fence;
  const TerritoryTileWidget({Key key, this.fence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TerritoryTileViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return model.isBusy
            ? BusyWidget()
            : ListTile(
                onTap: () => model.navigateToTerritoryDetail(fence),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        fence.name ?? "Unknown Territory",
                        style: kTileLeadingTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    model.isBusy
                        ? Text('- Km')
                        : Text(
                            '${model.distanceBetween.toStringAsFixed(2) ?? '-'} Km',
                            style: kTileLeadingSecondaryTextStyle),
                    SizedBox(width: 5),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  'STATUS : ${model.status}',
                  style: kTileSubtitleTextStyle,
                ),
              );
      },
      viewModelBuilder: () => TerritoryTileViewModel(fence),
    );
  }
}
