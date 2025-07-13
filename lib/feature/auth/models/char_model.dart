class CharModel {
  dynamic? date;
  String? characterName;
  String? worldName;
  String? characterGender;
  String? characterClass;
  String? characterClassLevel;
  int? characterLevel;
  int? characterExp;
  String? characterExpRate;
  String? characterGuildName;
  String? characterImage;
  String? characterDateCreate;
  String? accessFlag;
  String? liberationQuestClearFlag;

  CharModel(
      {this.date,
      this.characterName,
      this.worldName,
      this.characterGender,
      this.characterClass,
      this.characterClassLevel,
      this.characterLevel,
      this.characterExp,
      this.characterExpRate,
      this.characterGuildName,
      this.characterImage,
      this.characterDateCreate,
      this.accessFlag,
      this.liberationQuestClearFlag});

  CharModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    characterName = json['character_name'];
    worldName = json['world_name'];
    characterGender = json['character_gender'];
    characterClass = json['character_class'];
    characterClassLevel = json['character_class_level'];
    characterLevel = json['character_level'];
    characterExp = json['character_exp'];
    characterExpRate = json['character_exp_rate'];
    characterGuildName = json['character_guild_name'];
    characterImage = json['character_image'];
    characterDateCreate = json['character_date_create'];
    accessFlag = json['access_flag'];
    liberationQuestClearFlag = json['liberation_quest_clear_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['character_name'] = this.characterName;
    data['world_name'] = this.worldName;
    data['character_gender'] = this.characterGender;
    data['character_class'] = this.characterClass;
    data['character_class_level'] = this.characterClassLevel;
    data['character_level'] = this.characterLevel;
    data['character_exp'] = this.characterExp;
    data['character_exp_rate'] = this.characterExpRate;
    data['character_guild_name'] = this.characterGuildName;
    data['character_image'] = this.characterImage;
    data['character_date_create'] = this.characterDateCreate;
    data['access_flag'] = this.accessFlag;
    data['liberation_quest_clear_flag'] = this.liberationQuestClearFlag;
    return data;
  }
}
