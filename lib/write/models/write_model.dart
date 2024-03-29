class WriteModel {
  final String description;
  final String creatorUid;
  final String creator;
  final int createdAt;
  final int skillIndex;

  WriteModel({
    required this.description,
    required this.creatorUid,
    required this.creator,
    required this.createdAt,
    required this.skillIndex,
  });

  WriteModel.fromJson(Map<String, dynamic> json)
      : description = json["description"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        createdAt = json["createdAt"],
        skillIndex = json["skillIndex"];

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "creatorUid": creatorUid,
      "creator": creator,
      "createdAt": createdAt,
      "skillIndex": skillIndex,
    };
  }
}
