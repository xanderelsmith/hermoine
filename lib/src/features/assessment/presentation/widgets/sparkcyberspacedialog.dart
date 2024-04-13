import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/minimallisttilecard.dart';

class SparkCyberSpaceActivityDialog extends StatelessWidget {
  const SparkCyberSpaceActivityDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //
    return SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MinimalListTileCard(
                color: Theme.of(context).canvasColor,
                screensize: getScreenSize(context),
                child: const Center(child: Text('Pause Activity')),
              ),
              MinimalListTileCard(
                color: Theme.of(context).canvasColor,
                screensize: getScreenSize(context),
                child: const Center(child: Text('End Activity')),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                ),
                child: Text(
                  'Launch Activity',
                  style: AppTextStyle.mediumTitlename,
                ),
              ),
            ],
          ),
        ));
  }
}
