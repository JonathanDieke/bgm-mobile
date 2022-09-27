class UserProfile {
  String birthdate = '',
      ethnic = '',
      gender = 'male',
      diabetesType = 'type1',
      discoverDate = '',
      startTreatmentDate = '',
      treatmentType = '',
      physicActivities = '',
      job = '';
  bool isAlcoholic = false, isSmoker = false, isTense = false;
  int weight = 0, height = 0, pregnancies = 0;

  UserProfile(
      {required this.birthdate,
      required this.diabetesType,
      required this.discoverDate,
      required this.ethnic,
      required this.gender,
      required this.height,
      required this.isAlcoholic,
      required this.isSmoker,
      required this.isTense,
      required this.physicActivities,
      required this.pregnancies,
      required this.job,
      required this.startTreatmentDate,
      required this.treatmentType,
      required this.weight});

  UserProfile.empty();

  UserProfile edit(
      {String? birthdate,
      String? ethnic,
      String? gender,
      String? diabetesType,
      String? discoverDate,
      String? startTreatmentDate,
      String? treatmentType,
      String? physicActivities,
      String? job,
      bool? isAlcoholoc,
      bool? isSmoker,
      bool? isTense,
      int? height,
      int? weight,
      int? pregnancies}) {
    return UserProfile(
        birthdate: birthdate ?? this.birthdate,
        diabetesType: diabetesType ?? this.diabetesType,
        discoverDate: discoverDate ?? this.discoverDate,
        ethnic: ethnic ?? this.ethnic,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        isAlcoholic:
            isAlcoholic != this.isAlcoholic ? isAlcoholic : this.isAlcoholic,
        isSmoker: isSmoker ?? this.isSmoker,
        isTense: isTense ?? this.isTense,
        physicActivities: physicActivities ?? this.physicActivities,
        pregnancies:
            pregnancies != this.pregnancies ? pregnancies! : this.pregnancies,
        job: job ?? this.job,
        startTreatmentDate: startTreatmentDate ?? this.startTreatmentDate,
        treatmentType: treatmentType ?? this.treatmentType,
        weight: weight ?? this.weight);
  }

  Map<String, dynamic> toJson() => {
        'birthdate': birthdate,
        'diabetes_type': diabetesType,
        'discover_date': discoverDate,
        'ethnic': ethnic,
        'gender': gender,
        'height': height,
        'is_alcoholic': isAlcoholic,
        'is_smoker': isSmoker,
        'is_tense': isTense,
        'physic_activities': physicActivities,
        'pregnancies': pregnancies,
        'job': job,
        'start_treatment_date': startTreatmentDate,
        'treatment_type': treatmentType,
        'weight': weight,
      };

  static UserProfile fromJson(Map<String, dynamic> json) => UserProfile(
        birthdate: json['birthdate'],
        diabetesType: json['diabetes_type'],
        discoverDate: json['discover_date'],
        ethnic: json['ethnic'],
        gender: json['gender'],
        height: json['height'],
        isAlcoholic: json['is_alcoholic'],
        isSmoker: json['is_smoker'],
        isTense: json['is_tense'],
        physicActivities: json['physic_activities'],
        pregnancies: json['pregnancies'],
        job: json['job'],
        startTreatmentDate: json['start_treatment_date'],
        treatmentType: json['treatment_type'],
        weight: json['weight'],
      );
}
