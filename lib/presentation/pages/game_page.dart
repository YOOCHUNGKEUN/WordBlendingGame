import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ads/ad_service.dart';
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
  int _titleTapCount = 0;
  DateTime? _lastTitleTapAt;

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
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withOpacity(0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _handleTitleTap,
            child: SizedBox(
              width: 92,
              child: Stack(
                children: [
                  Text(
                    AppStrings.alrchmey_word,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4
                        ..color = Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    AppStrings.alrchmey_word,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.titleBlue,
                      shadows: [
                        Shadow(
                          color: AppColors.accent.withOpacity(0.8),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.accent, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.14),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const HintWidget(),
          ),
          const SizedBox(width: 7),

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
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.24),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('📖', style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 3),
                  Text(
                    AppStrings.word_field_guide,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  if (state.discoveredWords.isNotEmpty) ...[
                    const SizedBox(width: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${state.discoveredWords.length}',
                        style: TextStyle(
                          color: AppColors.textDark,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primaryLight, width: 2),
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

  void _handleTitleTap() {
    final now = DateTime.now();
    final lastTapAt = _lastTitleTapAt;
    if (lastTapAt == null || now.difference(lastTapAt).inSeconds > 2) {
      _titleTapCount = 0;
    }

    _lastTitleTapAt = now;
    _titleTapCount += 1;

    if (_titleTapCount >= 5) {
      _titleTapCount = 0;
      _showAdUnlockDialog(context);
    }
  }

  Future<void> _showAdUnlockDialog(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await showDialog<_AdUnlockResult>(
      context: context,
      builder: (_) => const _AdUnlockDialog(),
    );

    if (!mounted || result == null) return;

    if (result == _AdUnlockResult.success) {
      await AdService.instance.setAdsDisabled(true);
      messenger.showSnackBar(
        const SnackBar(content: Text('광고 제외가 적용됐어요.')),
      );
      return;
    }

    if (result == _AdUnlockResult.invalid) {
      messenger.showSnackBar(
        const SnackBar(content: Text('코드가 맞지 않아요.')),
      );
    }
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

enum _AdUnlockResult { success, invalid }

class _AdUnlockDialog extends StatefulWidget {
  const _AdUnlockDialog();

  @override
  State<_AdUnlockDialog> createState() => _AdUnlockDialogState();
}

class _AdUnlockDialogState extends State<_AdUnlockDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final result = AdService.instance.isValidUnlockCode(_controller.text)
        ? _AdUnlockResult.success
        : _AdUnlockResult.invalid;
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('광고 제외 코드'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
        decoration: const InputDecoration(
          hintText: '코드를 입력하세요',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('확인'),
        ),
      ],
    );
  }
}
