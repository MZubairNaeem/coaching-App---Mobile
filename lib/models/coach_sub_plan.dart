
class CoachSubPlanModel {
  String? coachId;
  String? subscriptionType;
  String? timeline;
  int? price;
  String? description;

  CoachSubPlanModel({
    this.coachId,
    this.subscriptionType,
    this.timeline,
    this.price,
    this.description,
  });

  CoachSubPlanModel.fromMap(Map<String, dynamic> map) {
    coachId = map['coachId'];
    subscriptionType = map['subscriptionType'];
    timeline = map['timeline'];
    price = map['price'];
    description = map['description'];
  }
  Map<String, dynamic> toMap() {
    return {
      'coachId': coachId,
      'subscriptionType': subscriptionType,
      'timeline': timeline,
      'price': price,
      'description': description,
    };
  }
}
