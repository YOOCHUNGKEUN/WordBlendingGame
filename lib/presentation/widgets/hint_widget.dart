// lib/presentation/widgets/hint_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import 'hint_popup.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({super.key});

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
          onDismiss: () =>
              context.read<GameBloc>().add(const HintDismissed()),
        );
      },
      child: GestureDetector(
        onTap: () => context.read<GameBloc>().add(const HintRequested()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('💡', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
              Text(
                '힌트',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}