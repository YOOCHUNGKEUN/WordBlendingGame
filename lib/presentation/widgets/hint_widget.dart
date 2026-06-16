// lib/presentation/widgets/hint_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ads/ad_service.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/services/word_lookup_resolver.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'hint_popup.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({super.key});

  // 힌트 버튼을 누르면 광고 안내 후 보상형 광고를 요청한다.
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
            content: Text(AppStrings.hintAdUnavailable),
          ),
        );
      },
    );
  }

  // 광고 시청 안내를 표시하고 사용자의 진행 여부를 반환한다.
  Future<bool> _showRewardedAdNotice(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(AppStrings.hintAdNoticeTitle),
        content: const Text(AppStrings.hintAdNoticeContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(AppStrings.hintAdConfirm),
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
        final resolver = WordLookupResolver.fromGameState(
          paletteWords: state.paletteWords,
          discoveredWords: state.discoveredWords,
          canvasWords: state.canvasWords,
          combinations: state.allCombinations,
        );

        showHintPopup(
          context,
          state.hintCombination!,
          word1Info: resolver.findWordInfo(state.hintCombination!.word1Id),
          word2Info: resolver.findWordInfo(state.hintCombination!.word2Id),
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
                AppStrings.hintButton,
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
