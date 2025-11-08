import 'package:flutter/material.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';
import 'package:flutter_space_scutum_test/widget/ink_well_material_widget.dart';

/// A card widget that displays task information.
///
/// The card shows the title, description, category, and allows interaction
/// through a checkbox (mark complete) and delete button.
class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
    required this.onToggleComplete,
    required this.onDelete,
    super.key,
  });

  /// Task title displayed at the top.
  final String title;

  /// Task description shown below the title.
  final String description;

  /// Category text (already formatted in parent layer).
  final String category;

  /// Determines whether the task is marked as completed.
  final bool isCompleted;

  /// Callback fired when the completion checkbox is toggled.
  final void Function()? onToggleComplete;

  /// Callback fired when the user presses the delete button.
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.colorGraphite,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: AppColors.colorGraphiteLine),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Left column: title, description, category
            Expanded(
              child: _TaskTextColumn(title: title, description: description, category: category, isDone: isCompleted),
            ),
            const SizedBox(width: 12),

            /// Right column: checkbox, delete button
            _TaskActionsColumn(isDone: isCompleted, onToggle: onToggleComplete, onDelete: onDelete),
          ],
        ),
      ),
    );
  }
}

/// Text column displaying the task's main information.
class _TaskTextColumn extends StatelessWidget {
  const _TaskTextColumn({required this.title, required this.description, required this.category, required this.isDone});

  final String title;
  final String description;
  final String category;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Task title (strikethrough if completed)
        Text(
          title,
          style: AppTextStyle.semibold16.copyWith(decoration: isDone ? TextDecoration.lineThrough : null),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),

        /// Task description
        Text(
          description,
          style: AppTextStyle.regular16.copyWith(fontSize: 14, decoration: isDone ? TextDecoration.lineThrough : null),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),

        /// Category label
        Text('Категорія: $category', style: AppTextStyle.medium14),
      ],
    );
  }
}

/// Column containing the checkbox and delete button.
class _TaskActionsColumn extends StatelessWidget {
  const _TaskActionsColumn({required this.isDone, required this.onToggle, required this.onDelete});

  final bool isDone;
  final void Function()? onToggle;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Checkbox button (toggle complete)
        _TaskCheckbox(isDone: isDone, onToggle: onToggle),

        /// Delete button
        _TaskDeleteButton(onDelete: onDelete),
      ],
    );
  }
}

/// Checkbox widget to toggle task completion.
///
/// Displays a check icon when completed, otherwise empty border.
class _TaskCheckbox extends StatelessWidget {
  const _TaskCheckbox({required this.isDone, required this.onToggle});

  final bool isDone;
  final void Function()? onToggle;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(6));

    return InkWellMaterialWidget(
      borderRadius: borderRadius,
      onTap: onToggle,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: isDone ? AppColors.colorAzureBlue : AppColors.colorMutedGray, width: 2),
          color: isDone ? AppColors.colorAzureBlue : Colors.transparent,
        ),
        child: isDone ? const Icon(Icons.check, size: 18, color: AppColors.colorPureWhite) : null,
      ),
    );
  }
}

/// Delete button inside the task card.
class _TaskDeleteButton extends StatelessWidget {
  const _TaskDeleteButton({required this.onDelete});

  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      onTap: onDelete,
      child: const Icon(Icons.delete_outline, color: AppColors.colorSoftRed, size: 28),
    );
  }
}
