// lib/presentation/widgets/game_canvas.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'word_card.dart';
import '../../core/theme/app_theme.dart';

class GameCanvas extends StatefulWidget {
  const GameCanvas({super.key});

  @override
  State<GameCanvas> createState() => _GameCanvasState();
}

class _GameCanvasState extends State<GameCanvas> {
  final TransformationController _transformController =
      TransformationController();

  // 드래그 중인 캔버스 단어 ID
  String? _draggingCanvasId;

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  /// 화면 좌표 → 캔버스 좌표 변환
  Offset _screenToCanvas(Offset screenOffset) {
    final Matrix4 inverse = Matrix4.inverted(_transformController.value);
    final transformed = MatrixUtils.transformPoint(inverse, screenOffset);
    return transformed;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return DragTarget<Word>(
          onAcceptWithDetails: (details) {
            // 팔레트에서 캔버스로 드래그 완료
            final RenderBox box =
                context.findRenderObject() as RenderBox;
            final localPos = box.globalToLocal(details.offset);
            final canvasPos = _screenToCanvas(localPos);

            context.read<GameBloc>().add(WordPlacedOnCanvas(
                  word: details.data,
                  x: canvasPos.dx,
                  y: canvasPos.dy,
                ));
          },
          builder: (context, candidateData, rejectedData) {
            final isHovering = candidateData.isNotEmpty;
            return Container(
              decoration: BoxDecoration(
                color: isHovering
                    ? AppTheme.primary.withOpacity(0.05)
                    : AppTheme.canvasBackground,
              ),
              child: ClipRect(
                child: InteractiveViewer(
                  transformationController: _transformController,
                  minScale: 0.4,
                  maxScale: 2.5,
                  boundaryMargin: const EdgeInsets.all(200),
                  child: SizedBox(
                    width: 2000,
                    height: 2000,
                    child: Stack(
                      children: [
                        // 격자 배경 (노트처럼)
                        _buildGridBackground(),
                        // 연결선 (합성 가능 힌트용 - 옵션)
                        // 캔버스 단어들
                        ...state.canvasWords.map((cw) => _buildDraggableWord(context, cw)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGridBackground() {
    return CustomPaint(
      size: const Size(2000, 2000),
      painter: _GridPainter(),
    );
  }

  Widget _buildDraggableWord(BuildContext context, CanvasWord canvasWord) {
    return Positioned(
      left: canvasWord.x - 50, // 카드 중앙 기준
      top: canvasWord.y - 26,
      child: GestureDetector(
        onPanUpdate: (details) {
          // InteractiveViewer 내부에서 드래그
          final RenderBox box = context.findRenderObject() as RenderBox;
          // 현재 transform 반영해서 델타를 캔버스 좌표로 변환
          final scale = _transformController.value.getMaxScaleOnAxis();
          final dx = details.delta.dx / scale;
          final dy = details.delta.dy / scale;

          context.read<GameBloc>().add(CanvasWordMoved(
                canvasId: canvasWord.canvasId,
                x: canvasWord.x + dx,
                y: canvasWord.y + dy,
              ));
        },
        onPanEnd: (details) {
          context.read<GameBloc>().add(WordDropped(
                draggedCanvasId: canvasWord.canvasId,
                dropX: canvasWord.x,
                dropY: canvasWord.y,
              ));
        },
        onLongPress: () {
          // 길게 누르면 삭제
          _showDeleteDialog(context, canvasWord);
        },
        child: WordCard(
          word: canvasWord.word,
          isOnCanvas: true,
          width: 108,
          height: 52,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CanvasWord canvasWord) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '${canvasWord.word.emoji} ${canvasWord.word.text}',
          style: const TextStyle(fontSize: 18),
        ),
        content: const Text('이 단어를 지울까요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<GameBloc>()
                  .add(CanvasWordDeleted(canvasId: canvasWord.canvasId));
              Navigator.pop(ctx);
            },
            child: const Text('지우기', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primary.withOpacity(0.07)
      ..strokeWidth = 1;
    const spacing = 40.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
