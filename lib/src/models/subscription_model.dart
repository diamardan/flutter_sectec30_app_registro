class Subscription {
  String careerTopic;
  String gradeTopic;
  String groupTopic;
  String turnTopic;

  Subscription(
      {this.careerTopic, this.gradeTopic, this.groupTopic, this.turnTopic});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        careerTopic: json["career_topic"],
        gradeTopic: json["grade_topic"],
        groupTopic: json["group_topic"],
        turnTopic: json["turn_topic"],
      );

  /* @override
  String toString() {
    var strOutput =
        " id $id\n name: $name \n surnames $surnames \n  curp: $curp \n email: $email \n cellphone: $cellphone \n  registrationCode: $registrationCode \n grade: $grade \n group: $group \n turn: $turn \n  sex: $sex \n  password: $password ";
    return strOutput;
  }*/

  Map<String, dynamic> toJson() => {
        "career_topic": careerTopic,
        "grade_topic": gradeTopic,
        "group_topic": groupTopic,
        "turn_topic": turnTopic,
      };
}
