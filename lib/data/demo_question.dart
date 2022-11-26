class Question {
  String question;
  bool answer;
  Question({
    required this.question,
    this.answer = false,
  });
}

List<Question> question = [
  Question(question: "Do you have disbetes?"),
  Question(question: "Have you ever had problem with your heart or lings?"),
  Question(question: "In the last 28 days do have you had COVID-19?"),
  Question(question: "Have you ever had cancer?"),
  Question(
      question: "Have you ever had a positive test for the HIV/AIDS virus?"),
  Question(question: "In the last 3 month have you had a vaccination?"),
];

class OnboardingContents {
  String title;
  String image;
  String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> onboardingContents = [
  OnboardingContents(
    title: "Welcome to Blood Donation App",
    image: "assets/images/welcome.png",
    desc:
        "User Will Able to create a donor account and will able to save lives",
  ),
  OnboardingContents(
    title: "Donate Blood",
    image: "assets/images/ob1.png",
    desc:
        "Users will able to find blood donors and request for blood for specific date,and & place",
  ),
  OnboardingContents(
    title: "Find Donors",
    image: "assets/images/demo3.png",
    desc:
        "In case of emergency users will be to get contact number of public account of donors.",
  ),
];
