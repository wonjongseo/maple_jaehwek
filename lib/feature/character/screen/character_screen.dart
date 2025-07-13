import 'package:flutter/material.dart';

import 'package:every_maple/core/constants/api_url.dart';
import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/core/utility/utilities.dart';
import 'package:every_maple/feature/character/models/character_model.dart';
import 'package:every_maple/feature/character/models/rank_model.dart';
import 'package:every_maple/feature/character/models/stat_model.dart';

import 'package:get/get.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  CharacterModel? characterModel;

  @override
  void initState() {
    // getMyCharacter();
    super.initState();
  }

  void getMyCharacter() async {
    final response = await Get.find<DioClient>()
        .get(ApiUrl.characterDetailByUid, queryParameters: {
      'ocid': '6e93f8fb6f84bcd6e9d15c4d8cc6b7c8efe8d04e6d233bd35cf2fabdeb93fb0d'
    });

    characterModel = CharacterModel.fromJson(response.data);

    String currentDate = getCurrentDate();
    print('currentDate : ${currentDate}');

    final rankResponse = await Get.find<DioClient>().get(
      ApiUrl.rankingOfCharacter,
      queryParameters: {
        'date': '2025-01-22',
        'ocid':
            '6e93f8fb6f84bcd6e9d15c4d8cc6b7c8efe8d04e6d233bd35cf2fabdeb93fb0d',
      },
    );

    characterModel!.ranking =
        RankingModel.fromJson(rankResponse.data['ranking'][0]);

    final statResponse = await Get.find<DioClient>().get(
      ApiUrl.characterStatByUid,
      queryParameters: {
        'ocid':
            '6e93f8fb6f84bcd6e9d15c4d8cc6b7c8efe8d04e6d233bd35cf2fabdeb93fb0d',
      },
    );

    characterModel!.stat = StatModel.fromJson(statResponse.data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton.small(onPressed: getMyCharacter),
      body: SafeArea(
        child: characterModel == null
            ? Container()
            : CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: SliverPersistentDelegate(user: characterModel!),
                    pinned: true,
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text(characterModel!.characterName!),
                        Row(
                          children: [
                            Text('길드 '),
                            Text(characterModel!.characterGuildName ?? "없음"),
                          ],
                        ),
                        Row(
                          children: [
                            Text('직업:'),
                            Text(characterModel!.characterName ?? ""),
                            Text('직업:'),
                            Text(
                                '(${characterModel!.characterClassLevel!.toString()}차)'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('경험치:'),
                            Text(characterModel!.ranking!.characterExp
                                .toString()),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('스텟'),
                              ],
                            ),
                            Divider(),
                            Builder(builder: (context) {
                              StatModel statModel = characterModel!.stat!;
                              return Column(
                                children: [
                                  if (statModel.getStatValue('전투력') != null)
                                    Container(
                                      margin: EdgeInsets.all(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF3e6076),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '전투력',
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              statModel.getStatValue('전투력')!,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                // color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  SizedBox(height: 10),
                                  StatBoxWidget(
                                    boxColor: const Color(0xFF86939f),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatWidget(
                                                statName: "HP",
                                                statValue: statModel
                                                    .getStatValue('HP')!,
                                              ),
                                              StatWidget(
                                                statName: "STR",
                                                statValue: statModel
                                                    .getStatValue('STR')!,
                                              ),
                                              StatWidget(
                                                statName: "INT",
                                                statValue: statModel
                                                    .getStatValue('INT')!,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatWidget(
                                                statName: "MP",
                                                statValue: statModel
                                                    .getStatValue('MP')!,
                                              ),
                                              StatWidget(
                                                statName: "DEX",
                                                statValue: statModel
                                                    .getStatValue('DEX')!,
                                              ),
                                              StatWidget(
                                                statName: "LUK",
                                                statValue: statModel
                                                    .getStatValue('LUK')!,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  StatBoxWidget(
                                    boxColor: Color(0xFF6c7785),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatWidget(
                                                statName: "최대 스탯공격력",
                                                statValue: statModel
                                                    .getStatValue('최대 스탯공격력'),
                                              ),
                                              StatWidget(
                                                statName: "최종 데미지",
                                                statValue: statModel
                                                    .getStatValue('최종 데미지'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "방어율 무시",
                                                statValue: statModel
                                                    .getStatValue('방어율 무시'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "공격력",
                                                statValue: statModel
                                                    .getStatValue('공격력'),
                                              ),
                                              StatWidget(
                                                statName: "마력",
                                                statValue: statModel
                                                    .getStatValue('마력'),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("재사용 대기시간 감소"),
                                                  Text(
                                                    '${statModel.getStatValue('재사용 대기시간 감소 (초)')!}초/${statModel.getStatValue('재사용 대기시간 감소 (%)')!}%',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              StatWidget(
                                                statName: "재사용 대기시간 미적용",
                                                statValue:
                                                    statModel.getStatValue(
                                                        '재사용 대기시간 미적용'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "상태이상 추가 데미지",
                                                statValue:
                                                    statModel.getStatValue(
                                                        '상태이상 추가 데미지'),
                                                statValueSuffic: '%',
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatWidget(
                                                statName: "데미지",
                                                statValue: statModel
                                                    .getStatValue('데미지'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "보스 몬스터 데미지",
                                                statValue: statModel
                                                    .getStatValue('보스 몬스터 데미지'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "일반 몬스터 데미지",
                                                statValue: statModel
                                                    .getStatValue('일반 몬스터 데미지'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "크리티컬 확률",
                                                statValue: statModel
                                                    .getStatValue('크리티컬 확률'),
                                              ),
                                              StatWidget(
                                                statName: "크리티컬 데미지",
                                                statValue: statModel
                                                    .getStatValue('크리티컬 데미지'),
                                              ),
                                              StatWidget(
                                                statName: "버프 지속시간",
                                                statValue: statModel
                                                    .getStatValue('버프 지속시간'),
                                              ),
                                              StatWidget(
                                                statName: "속성 내성 무시",
                                                statValue: statModel
                                                    .getStatValue('속성 내성 무시'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "소환수 지속시간 증가",
                                                statValue:
                                                    statModel.getStatValue(
                                                        '소환수 지속시간 증가'),
                                                statValueSuffic: '%',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  StatBoxWidget(
                                    boxColor: Color(0xFF6c7785),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatWidget(
                                                statName: "메소 획득량",
                                                statValue: statModel
                                                    .getStatValue('메소 획득량'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "아이템 드롭률",
                                                statValue: statModel
                                                    .getStatValue('아이템 드롭률'),
                                                statValueSuffic: '%',
                                              ),
                                              StatWidget(
                                                statName: "추가 경험치 획득",
                                                statValue: statModel
                                                    .getStatValue('추가 경험치 획득'),
                                                statValueSuffic: '%',
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatWidget(
                                                statName: "스타포스",
                                                statValue: statModel
                                                    .getStatValue('스타포스')!,
                                              ),
                                              StatWidget(
                                                statName: "아케인포스",
                                                statValue: statModel
                                                    .getStatValue('아케인포스')!,
                                              ),
                                              StatWidget(
                                                statName: "어센틱포스",
                                                statValue: statModel
                                                    .getStatValue('어센틱포스')!,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        )
                      ],
                    ),
                  )
                  // Center(
                  //   child: SingleChildScrollView(
                  //     child:
                  //  ),
                  // ),
                ],
              ),
      ),
    );
  }
}

class StatBoxWidget extends StatefulWidget {
  const StatBoxWidget({
    Key? key,
    required this.boxColor,
    required this.child,
  }) : super(key: key);
  final Color boxColor;
  final Widget child;

  @override
  State<StatBoxWidget> createState() => _StatBoxWidgetState();
}

class _StatBoxWidgetState extends State<StatBoxWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: widget.child,
      // child: Flexible(
      //   child: PageView.builder(
      //     itemCount: 2,
      //     itemBuilder: (context, index) {
      //       return widget.child;
      //     },
      //   ),
      // ),
    );
  }
}

class StatWidget extends StatelessWidget {
  const StatWidget({
    super.key,
    required this.statName,
    this.statValue,
    this.statValueSuffic,
  });

  final String statName;
  final String? statValue;
  final String? statValueSuffic;

  @override
  Widget build(BuildContext context) {
    if (statValue == null) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          statName,
          style: TextStyle(color: Colors.white70),
        ),
        Text(
          '${statValue!}${statValueSuffic ?? ""}',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final CharacterModel user;

  final double maxHeaderHeight = 180;
  final double minHeaderHeight = kToolbarHeight + 20;
  final double maxImageSize = 130;
  final double minImageSize = 40;

  SliverPersistentDelegate({required this.user});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final Size size = MediaQuery.of(context).size;
    final percent = shrinkOffset / (maxHeaderHeight - 35);
    final percent2 = shrinkOffset / (maxHeaderHeight);
    final currentImageSize = (maxImageSize * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final currentImagePosition = ((size.width / 2 - 65) * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    print('currentImagePosition : ${currentImagePosition}');

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            left: currentImagePosition,
            top: MediaQuery.of(context).viewPadding.top + 5,
            bottom: 0,
            child: Hero(
              tag: 'profile',
              child: Container(
                width: currentImageSize,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.characterImage!, scale: 1 / 2),
                    )
                    // image: user.profileImageUrl.isNotEmpty
                    //     ? DecorationImage(
                    //         image: CachedNetworkImageProvider(
                    //           user.profileImageUrl,
                    //         ),
                    //       )
                    //     : null,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

/**
 
flutter: 0 : 최소 스탯공격력
flutter: 1 : 최대 스탯공격력
flutter: 2 : 데미지
flutter: 3 : 보스 몬스터 데미지
flutter: 4 : 최종 데미지
flutter: 5 : 방어율 무시
flutter: 6 : 크리티컬 확률
flutter: 7 : 크리티컬 데미지
flutter: 8 : 상태이상 내성
flutter: 9 : 스탠스
flutter: 10 : 방어력
flutter: 11 : 이동속도
flutter: 12 : 점프력
flutter: 13 : 스타포스
flutter: 14 : 아케인포스
flutter: 15 : 어센틱포스
flutter: 16 : STR
flutter: 17 : DEX
flutter: 18 : INT
flutter: 19 : LUK
flutter: 20 : HP
flutter: 21 : MP
flutter: 22 : AP 배분 STR
flutter: 23 : AP 배분 DEX
flutter: 24 : AP 배분 INT
flutter: 25 : AP 배분 LUK
flutter: 26 : AP 배분 HP
flutter: 27 : AP 배분 MP
flutter: 28 : 아이템 드롭률
flutter: 29 : 메소 획득량
flutter: 30 : 버프 지속시간
flutter: 31 : 공격 속도
flutter: 32 : 일반 몬스터 데미지
flutter: 33 : 재사용 대기시간 감소 (초)
flutter: 34 : 재사용 대기시간 감소 (%)
flutter: 35 : 재사용 대기시간 미적용
flutter: 36 : 속성 내성 무시
flutter: 37 : 상태이상 추가 데미지
flutter: 38 : 무기 숙련도
flutter: 39 : 추가 경험치 획득
flutter: 40 : 공격력
flutter: 41 : 마력
flutter: 42 : 전투력
flutter: 43 : 소환수 지속시간 증가


 */
// enum StatType {
//   MIN_STAT_POWER("최소 스탯공격력", 0),
//   MAX_STAT_POWER("최대 스탯공격력", 1),
//   MAX_STAT_POWER("데미지", 2),
//   MAX_STAT_POWER("보스 몬스터 데미지", 3),
//   MAX_STAT_POWER("최종 데미지", 4),
//   MAX_STAT_POWER("방어율 무시", 5),
//   MAX_STAT_POWER("크리티컬 확률", 6),
//   MAX_STAT_POWER("크리티컬 데미지", 7),
//   tolerance("상태이상 내성", 8),
//   STANCE("스탠스", 9),
//   DEFENSIVE_ABILITY("방어력", 10),
//   RATE_OF_MOVEMENT("이동속도", 11),
//   JUMPING_ABILITY("점프력", 12),


//   final String statName;
//   final int statIndex;

//   const StatType(this.statName, this.statIndex);
// }


