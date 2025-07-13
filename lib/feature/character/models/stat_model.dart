class StatModel {
  String? date;
  String? characterClass;
  List<FinalStat>? finalStat;
  int? remainAp;

  String getStatValue(String statName) {
    if (finalStat == null) return "";

    for (var stat in finalStat!) {
      if (stat.statName == statName) {
        return stat.statValue ?? "";
      }
    }
    return "";
  }

  StatModel({this.date, this.characterClass, this.finalStat, this.remainAp});

  StatModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    characterClass = json['character_class'];
    if (json['final_stat'] != null) {
      finalStat = <FinalStat>[];
      json['final_stat'].forEach((v) {
        finalStat!.add(new FinalStat.fromJson(v));
      });
    }
    remainAp = json['remain_ap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['character_class'] = this.characterClass;
    if (this.finalStat != null) {
      data['final_stat'] = this.finalStat!.map((v) => v.toJson()).toList();
    }
    data['remain_ap'] = this.remainAp;
    return data;
  }

  @override
  String toString() {
    return 'StatModel(date: $date, characterClass: $characterClass, finalStat: $finalStat, remainAp: $remainAp)';
  }
}

class FinalStat {
  String? statName;
  String? statValue;

  FinalStat({this.statName, this.statValue});

  FinalStat.fromJson(Map<String, dynamic> json) {
    statName = json['stat_name'];
    statValue = json['stat_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stat_name'] = this.statName;
    data['stat_value'] = this.statValue;
    return data;
  }

  @override
  String toString() => 'FinalStat(statName: $statName, statValue: $statValue)';
}
