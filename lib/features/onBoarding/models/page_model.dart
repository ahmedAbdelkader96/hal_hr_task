class PageModel {
  String title;
  String desc;
  String lottiePath;

  PageModel({
    required this.title,
    required this.desc,
    required this.lottiePath,
  });
}

List<PageModel> getSlides() {
  List<PageModel> slides = [];

  slides.add(
    PageModel(
      title: "Travel the World",
      desc: "Explore new destinations and embrace diverse cultures",
      lottiePath: 'assets/animations/onboarding_animation.json',
    ),
  );
  slides.add(
    PageModel(
      title: "Present Connections",
      desc: "Celebrate meaningful communication and shared experiences",
      lottiePath: 'assets/animations/home.json',
    ),
  );
  slides.add(
    PageModel(
      title: "Connecting the Globe",
      desc: "Unite with a global community through seamless connections",
      lottiePath: 'assets/animations/travel_tickets.json',
    ),
  );

  return slides;
}
