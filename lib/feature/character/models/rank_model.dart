class RankingModel {
  String? date;
  String? worldName;
  int? ranking;
  String? characterName;
  int? characterLevel;
  int? characterExp;
  String? className;
  String? subClassName;
  int? characterPopularity;
  String? characterGuildname;

  RankingModel(
      {this.date,
      this.worldName,
      this.ranking,
      this.characterName,
      this.characterLevel,
      this.characterExp,
      this.className,
      this.subClassName,
      this.characterPopularity,
      this.characterGuildname});

  RankingModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    worldName = json['world_name'];
    ranking = json['ranking'];
    characterName = json['character_name'];
    characterLevel = json['character_level'];
    characterExp = json['character_exp'];
    className = json['class_name'];
    subClassName = json['sub_class_name'];
    characterPopularity = json['character_popularity'];
    characterGuildname = json['character_guildname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['world_name'] = this.worldName;
    data['ranking'] = this.ranking;
    data['character_name'] = this.characterName;
    data['character_level'] = this.characterLevel;
    data['character_exp'] = this.characterExp;
    data['class_name'] = this.className;
    data['sub_class_name'] = this.subClassName;
    data['character_popularity'] = this.characterPopularity;
    data['character_guildname'] = this.characterGuildname;
    return data;
  }
}
