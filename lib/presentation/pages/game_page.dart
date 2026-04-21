import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../widgets/game_canvas.dart';
import '../widgets/hint_widget.dart';
import '../widgets/word_palette.dart';
import '../widgets/combination_result_popup.dart';
import 'recipe_book_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().add(const GameInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasBackground,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false, // 하단은 팔레트에서 padding.bottom으로 직접 처리
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Stack(
              children: [Column(
                  children: [
                    _buildAppBar(context, state),
                    Expanded(child: const GameCanvas()),
                    const WordPalette(),
                  ],
                ),
                if (state.status == GameStatus.loading)
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: AppColors.primary),
                          const SizedBox(height: 16),
                          const Text(AppStrings.calling_words),
                        ],
                      ),
                    ),
                  ),
                if (state.showCombinationResult && state.lastCombination != null)
                  CombinationResultPopup(combination: state.lastCombination!, onDismiss: () => context
                        .read<GameBloc>()
                        .add(const CombinationResultDismissed()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, GameState state) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 타이틀
          const Text('🔮', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              AppStrings.alrchmey_word,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.textDark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),

          // 힌트 버튼
          const HintWidget(),
          const SizedBox(width: 6),

          // 도감 버튼
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<GameBloc>(),
                  child: const RecipeBookPage(),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('📖', style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 3),
                  Text(
                    AppStrings.word_field_guide,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  if (state.discoveredWords.isNotEmpty) ...[
                    const SizedBox(width: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${state.discoveredWords.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),

          // 청소 버튼
          GestureDetector(
            onTap: () => _showClearDialog(context),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.cleaning_services_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('캔버스 지우기'),
        content: const Text('캔버스의 모든 단어를 지울까요?\n팔레트의 단어는 그대로예요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              context.read<GameBloc>().add(const CanvasCleared());
              Navigator.pop(ctx);
            },
            child: const Text('지우기',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}