import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class SpeakersSection extends StatelessWidget {
  const SpeakersSection({
    super.key,
    required this.speakers,
    required this.avatarDimension,
    required this.titleTextStyle,
    required this.extendedSubtitle,
    this.ended = false,
    this.axis = Axis.horizontal,
    this.onSpeakerTap,
  });

  final List<Speaker> speakers;
  final double avatarDimension;
  final AppTextStyle titleTextStyle;
  final bool extendedSubtitle;
  final bool ended;
  final Axis axis;
  final ValueChanged<Speaker>? onSpeakerTap;

  @override
  Widget build(BuildContext context) {
    final children = [
      for (final speaker in speakers)
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: switch (onSpeakerTap) {
            final onSpeakerTap? => () => onSpeakerTap(speaker),
            null => null,
          },
          child: _SpeakerSection(
            ended: ended,
            speaker: speaker,
            avatarDimension: avatarDimension,
            titleTextStyle: titleTextStyle,
            extendedSubtitle: extendedSubtitle,
          ),
        ),
    ];

    return switch (axis) {
      Axis.vertical => Column(children: children.spaced(AppSpacings.s12)),
      Axis.horizontal => Row(
        children: [for (final child in children) Expanded(child: child)],
      ),
    };
  }
}

class _SpeakerSection extends StatelessWidget {
  const _SpeakerSection({
    required this.speaker,
    required this.avatarDimension,
    required this.titleTextStyle,
    required this.extendedSubtitle,
    required this.ended,
  });

  final Speaker speaker;
  final double avatarDimension;
  final AppTextStyle titleTextStyle;
  final bool extendedSubtitle;
  final bool ended;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final Speaker(:photoUrl, :fullName, :jobTitle, :companyName) = speaker;

    final subtitle = switch (extendedSubtitle) {
      false => companyName,
      true => switch ((companyName, jobTitle)) {
        (final companyName?, final jobTitle?) =>
          s.common_speakerLongDescription(
            jobTitle: jobTitle,
            companyName: companyName,
          ),
        _ => null,
      },
    };

    return Row(
      children: [
        // TODO: Figure out why this is nullable
        if (photoUrl != null)
          Container(
            width: avatarDimension,
            height: avatarDimension,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colors.foregroundDefaultQuaternary,
            ),
            child: CachedNetworkImage(imageUrl: photoUrl.toString()),
          ),
        AppSpacings.s8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                fullName,
                style: titleTextStyle,
                color: switch (ended) {
                  true => colors.foregroundDefaultSecondary,
                  false => colors.foregroundDefaultPrimary,
                },
                maxLines: 1,
              ),
              if (subtitle != null) ...[
                AppSpacings.s4.verticalSpace,
                AppText(
                  subtitle,
                  style: AppTextStyles.captionDefault,
                  color: colors.foregroundDefaultSecondary,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
