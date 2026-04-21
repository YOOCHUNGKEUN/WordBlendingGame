// lib/presentation/widgets/game_canvas.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'word_card.dart';
import '../../core/constants/app_colors.dart';

const double _cardW = 108.0;
const double _cardH = 52.0;

class GameCanvas extends StatefulWidget {
  const GameCanvas({super.key});

  @override
  State<GameCanvas> createState() => _GameCanvasState();
}

class _GameCanvasState extends State<GameCanvas> {
  final TransformationController _transformController =
  TransformationController();

  double _canvasW = 2000;
  double _canvasH = 4000;

  final Map<String, _DragStartInfo> _dragStartInfo = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    _canvasW = size.width * 10;
    _canvasH = size.height * 10;

    final offsetX = (_canvasW / 2) - (size.width / 2);
    final offsetY = (_canvasH / 2) - (size.height / 2);
    _transformController.value = Matrix4.identity()
      ..translate(-offsetX, -offsetY);
  }

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  Offset _toCanvasCoord(Offset viewportOffset) {
    final Matrix4 inverse = Matrix4.inverted(_transformController.value);
    return MatrixUtils.transformPoint(inverse, viewportOffset);
  }

  Offset _globalToCanvas(Offset globalOffset) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localOffset = box.globalToLocal(globalOffset);
    return _toCanvasCoord(localOffset);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return DragTarget<Word>(
          onAcceptWithDetails: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            // details.offset은 드래그 피드백 위젯의 좌상단 기준
            // 카드 중앙으로 보정해줘야 함
            final localPos = box.globalToLocal(details.offset);
            final canvasPos = _toCanvasCoord(Offset(
              localPos.dx + _cardW / 2,  // ← 카드 너비 절반 더하기
              localPos.dy + _cardH / 2,  // ← 카드 높이 절반 더하기
            ));

            context.read<GameBloc>().add(WordDroppedFromPalette(
              word: details.data,
              x: canvasPos.dx,
              y: canvasPos.dy,
            ));
          },          builder: (context, candidateData, rejectedData) {
            final isHovering = candidateData.isNotEmpty;
            return LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: isHovering
                      ? AppColors.primary.withOpacity(0.05)
                      : AppColors.canvasBackground,
                  child: ClipRect(
                    child: InteractiveViewer(
                      transformationController: _transformController,
                      minScale: 0.3,
                      maxScale: 3.0,
                      boundaryMargin:
                      const EdgeInsets.all(double.infinity),
                      constrained: false,
                      child: SizedBox(
                        width: _canvasW,
                        height: _canvasH,
                        child: Stack(
                          children: [
                            _buildGridBackground(),
                            ...state.canvasWords.map(
                                  (cw) => _buildDraggableWord(context, cw),
                            ),
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
      },
    );
  }

  Widget _buildGridBackground() {
    return CustomPaint(
      size: Size(_canvasW, _canvasH),
      painter: _GridPainter(canvasW: _canvasW, canvasH: _canvasH),
    );
  }

  Widget _buildDraggableWord(BuildContext context, CanvasWord canvasWord) {
    return Positioned(
      left: canvasWord.x - _cardW / 2,
      top: canvasWord.y - _cardH / 2,
      child: GestureDetector(
        onPanStart: (details) {
          final fingerCanvasPos =
          _globalToCanvas(details.globalPosition);
          _dragStartInfo[canvasWord.canvasId] = _DragStartInfo(
            cardStartPos: Offset(canvasWord.x, canvasWord.y),
            fingerStartPos: fingerCanvasPos,
          );
        },
        onPanUpdate: (details) {
          final info = _dragStartInfo[canvasWord.canvasId];
          if (info == null) return;

          final fingerNow = _globalToCanvas(details.globalPosition);
          final delta = fingerNow - info.fingerStartPos;

          final newX = info.cardStartPos.dx + delta.dx;
          final newY = info.cardStartPos.dy + delta.dy;

          _dragStartInfo[canvasWord.canvasId] = _DragStartInfo(
            cardStartPos: info.cardStartPos,
            fingerStartPos: info.fingerStartPos,
            currentPos: Offset(newX, newY),
          );

          context.read<GameBloc>().add(CanvasWordMoved(
            canvasId: canvasWord.canvasId,
            x: newX,
            y: newY,
          ));
        },
        onPanEnd: (_) {
          final info = _dragStartInfo[canvasWord.canvasId];
          final currentPos =
              info?.currentPos ?? Offset(canvasWord.x, canvasWord.y);
          _dragStartInfo.remove(canvasWord.canvasId);

          context.read<GameBloc>().add(WordDropped(
            draggedCanvasId: canvasWord.canvasId,
            dropX: currentPos.dx,
            dropY: currentPos.dy,
          ));
        },
        onLongPress: () => _showDeleteDialog(context, canvasWord),
        child: WordCard(
          word: canvasWord.word,
          isOnCanvas: true,
          width: _cardW,
          height: _cardH,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CanvasWord canvasWord) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title:
        Text('${canvasWord.word.emoji} ${canvasWord.word.text}'),
        content: const Text('이 단어를 지울까요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              context.read<GameBloc>().add(
                  CanvasWordDeleted(canvasId: canvasWord.canvasId));
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

class _DragStartInfo {
  final Offset cardStartPos;
  final Offset fingerStartPos;
  final Offset? currentPos;

  const _DragStartInfo({
    required this.cardStartPos,
    required this.fingerStartPos,
    this.currentPos,
  });
}

class _GridPainter extends CustomPainter {
  final double canvasW;
  final double canvasH;

  const _GridPainter({required this.canvasW, required this.canvasH});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.07)
      ..strokeWidth = 1;
    const spacing = 40.0;
    for (double x = 0; x <= canvasW; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, canvasH), paint);
    }
    for (double y = 0; y <= canvasH; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(canvasW, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) =>
      old.canvasW != canvasW || old.canvasH != canvasH;
}