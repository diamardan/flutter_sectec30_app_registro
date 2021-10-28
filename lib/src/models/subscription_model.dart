class Subscription {
  String careerTopic;
  String gradeTopic;
  String groupTopic;
  String turnTopic;
  String schoolTopic;

  Subscription(
      {this.careerTopic,
      this.gradeTopic,
      this.groupTopic,
      this.turnTopic,
      this.schoolTopic});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        careerTopic: json["career_topic"],
        gradeTopic: json["grade_topic"],
        groupTopic: json["group_topic"],
        turnTopic: json["turn_topic"],
        schoolTopic: json["school_topic"],
      );

  Map<String, dynamic> toJson() => {
        "career_topic": careerTopic,
        "grade_topic": gradeTopic,
        "group_topic": groupTopic,
        "turn_topic": turnTopic,
        "school_topic": schoolTopic,
      };
}
