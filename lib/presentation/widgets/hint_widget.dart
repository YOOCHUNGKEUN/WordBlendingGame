// lib/presentation/widgets/hint_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ads/ad_service.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'hint_popup.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({super.key});

  Future<void> _handleTap(BuildContext context) async {
    final shouldShowAd = await _showRewardedAdNotice(context);
    if (!shouldShowAd || !context.mounted) return;

    final bloc = context.read<GameBloc>();
    AdService.instance.showRewardedHintAd(
      onRewardEarned: () {
        if (context.mounted) {
          bloc.add(const HintRequested());
        }
      },
      onAdUnavailable: () {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('광고가 아직 준비되지 않았어요. 잠시 후 다시 시도해 주세요.'),
          ),
        );
      },
    );
  }

  Future<bool> _showRewardedAdNotice(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('광고 시청 안내'),
        content: const Text(
          '힌트는 보상형 광고를 시청한 뒤 받을 수 있어요.\n\n'
          '광고는 단어팡의 게임 내용이 아니며, 광고 화면으로 이동합니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('광고 보고 힌트 받기'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listenWhen: (prev, curr) =>
          curr.hintCombination != null &&
          prev.hintCombination != curr.hintCombination,
      listener: (context, state) {
        // ✅ 팝업을 먼저 띄우고, 팝업 안에서 닫힐 때 HintDismissed 호출
        showHintPopup(
          context,
          state.hintCombination!,
          onDismiss: () => context.read<GameBloc>().add(
            const HintDismissed(),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _handleTap(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('💡', style: TextStyle(fontSize: 13)),
              SizedBox(width: 3),
              Text(
                '광고 보고 힌트',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.popOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
