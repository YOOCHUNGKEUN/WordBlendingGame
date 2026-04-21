// lib/presentation/pages/game_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../widgets/game_canvas.dart';
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
      backgroundColor: AppTheme.canvasBackground,
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Stack(
            children: [
              // ─── 메인 레이아웃 ───────────────────────
              Column(
                children: [
                  // 상단 앱바
                  _buildAppBar(context, state),
                  // 캔버스 영역
                  Expanded(child: const GameCanvas()),
                  // 하단 팔레트
                  const WordPalette(),
                ],
              ),

              // ─── 로딩 오버레이 ─────────────────────
              if (state.status == GameStatus.loading)
                Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: AppTheme.primary),
                        const SizedBox(height: 16),
                        const Text('단어 카드를 불러오는 중...'),
                      ],
                    ),
                  ),
                ),

              // ─── 합성 결과 팝업 ────────────────────
              if (state.showCombinationResult &&
                  state.lastCombination != null)
                CombinationResultPopup(
                  combination: state.lastCombination!,
                  onDismiss: () => context
                      .read<GameBloc>()
                      .add(const CombinationResultDismissed()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, GameState state) {
    return SafeArea(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 타이틀
            Row(
              children: [
                Text('🔮', style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  '단어 연금술사',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
            const Spacer(),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      '📖',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '도감',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                    if (state.discoveredWords.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
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
            const SizedBox(width: 8),
            // 캔버스 지우기
            GestureDetector(
              onTap: () => _showClearDialog(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.cleaning_services_rounded,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
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
            child: const Text(
              '지우기',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
