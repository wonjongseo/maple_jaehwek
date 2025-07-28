// ui/record_form_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/record_controller.dart';
import '../models/record_model.dart';

class RecordFormView extends StatefulWidget {
  const RecordFormView({super.key, required this.date});
  final DateTime date; // 달력에서 클릭한 날짜

  @override
  State<RecordFormView> createState() => _RecordFormViewState();
}

class _RecordFormViewState extends State<RecordFormView> {
  final _fKey = GlobalKey<FormState>();
  final _cj = TextEditingController();
  final _se = TextEditingController();
  final _meso = TextEditingController();
  late final bool _isEdit; // 수정 모드 여부

  @override
  void initState() {
    super.initState();
    final ctrl = Get.find<RecordController>();
    final existing = ctrl.recordOf(widget.date);

    _isEdit = existing != null;
    if (existing != null) {
      _cj.text = existing.crystalJamCnt.toString();
      _se.text = existing.solErdaFragmentCnt.toString();
      _meso.text = existing.meso.toString();
    }
  }

  @override
  void dispose() {
    _cj.dispose();
    _se.dispose();
    _meso.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_fKey.currentState!.validate()) return;

    final ctrl = Get.find<RecordController>();
    final record = RecordModel(
      dateTime: widget.date,
      crystalJamCnt: int.parse(_cj.text),
      solErdaFragmentCnt: int.parse(_se.text),
      meso: int.parse(_meso.text),
    );

    await ctrl.save(record); // 신규·수정 동일 Upsert
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_isEdit ? '기록 수정' : '기록 추가')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _fKey,
            child: ListView(
              children: [
                // 머리글: 날짜
                Center(
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(widget.date),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 32),
                // 입력 필드들
                _numField(_cj, '크리스탈 젬 개수'),
                _numField(_se, '솔 에르다 파편 개수'),
                _numField(_meso, '메소'),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('저장'),
                ),
              ],
            ),
          ),
        ),
      );

  // 숫자 전용 TextFormField 헬퍼
  Widget _numField(TextEditingController ctrl, String label) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: label),
          validator: (v) => (v == null || v.isEmpty) ? '값을 입력하세요' : null,
        ),
      );
}
