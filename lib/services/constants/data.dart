part of constants;

class Data {
  static List<CardData> rowCardData = [
    CardData(
      leadingIcon: Icons.done,
      trailingIcon: Icons.bubble_chart_outlined,
      title: Strings.design,
      subtitle: Strings.designDesc,
    ),
    CardData(
      leadingIcon: Icons.done,
      trailingIcon: Icons.bubble_chart_outlined,
      title: Strings.development,
      subtitle: Strings.developmentDesc,
      circleBgColor: AppColors.primaryColor,
    ),
    CardData(
      leadingIcon: Icons.done,
      trailingIcon: Icons.bubble_chart_outlined,
      title: Strings.freelance,
      subtitle: Strings.freelanceDesc,
    ),
  ];

  static List<StatItemData> statItemsData = [
    StatItemData(value: 1, subtitle: Strings.experience),
    StatItemData(value: getNumberOfCoffeeCups(), subtitle: Strings.coffee),
    StatItemData(value: 10, subtitle: Strings.projects),
    StatItemData(value: 0, subtitle: Strings.touchedGrass),
  ];

  static List<SocialButtonData> socialData = [
    SocialButtonData(
      tag: Strings.twitterTag,
      url: Strings.twitterUrl,
      iconData: CustomIcons.twitter,
    ),
    SocialButtonData(
      tag: Strings.githubTag,
      url: Strings.githubUrl,
      iconData: CustomIcons.github,
    ),
    SocialButtonData(
      tag: Strings.linkedInTag,
      url: Strings.linkedInUrl,
      iconData: CustomIcons.linkedin,
    ),
    SocialButtonData(
      tag: Strings.discordTag,
      url: Strings.discordUrl,
      iconData: CustomIcons.discord,
    ),
  ];
}

int getNumberOfCoffeeCups() {
  final now = DateTime.now();
  final startDate = DateTime(2022, 1, 1);

  final daysPassed = now.difference(startDate);
  return daysPassed.inDays;
}