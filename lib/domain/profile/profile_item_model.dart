class ProfileItemModel {
  final String title;
  final String image;
  final Function() onTap;

  ProfileItemModel({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
