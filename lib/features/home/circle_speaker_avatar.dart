import 'package:app_design_system/app_design_system.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/routes.dart';

class CircleSpeakerAvatar extends StatelessWidget {
  const CircleSpeakerAvatar({super.key, required this.speaker});

  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final Speaker(:fullName, :jobTitle, :companyName, :companyPhotoUrl) =
        speaker;

    return GestureDetector(
      key: keys.home.speakerAvatar(speaker.id),
      onTap: () => SpeakerRoute(speakerId: speaker.id).go(context),
      child: SizedBox(
        width: 126,
        child: Column(
          children: [
            Container(
              width: 116,
              height: 116,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.foregroundDefaultQuaternary,
              ),
              child: CachedNetworkImage(
                imageUrl: speaker.photoUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
            AppSpacings.s12.verticalSpace,
            AppText(
              fullName,
              style: AppTextStyles.bodyStrong,
              color: colors.foregroundDefaultPrimary,
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.longestLine,
            ),
            if (jobTitle != null) ...[
              AppSpacings.s4.verticalSpace,
              AppText(
                jobTitle,
                style: AppTextStyles.captionDefault,
                textAlign: TextAlign.center,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
            ],
            AppSpacings.s8.verticalSpace,
            if (companyPhotoUrl != null)
              CachedNetworkImage(
                height: 20,
                imageUrl: companyPhotoUrl.toString(),
              ),
          ],
        ),
      ),
    );
  }
}
