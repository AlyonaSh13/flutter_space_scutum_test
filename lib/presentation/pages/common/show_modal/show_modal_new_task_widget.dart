import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_category.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:flutter_space_scutum_test/presentation/blocs/task/task_bloc.dart';
import 'package:flutter_space_scutum_test/presentation/pages/common/dialogs/dialog_helper.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';
import 'package:flutter_space_scutum_test/widget/button/app_dropdown.dart';
import 'package:flutter_space_scutum_test/widget/button/button_widget.dart';
import 'package:flutter_space_scutum_test/widget/text_field_widget.dart';
import 'package:go_router/go_router.dart';

/// Modal bottom sheet used for creating a new task.
///
/// Responsibilities:
/// - provide input fields for title, description, and category
/// - validate user input
/// - dispatch TaskAddEvent to [TaskBloc]
/// - show errors and handle success (close sheet on success)
class ShowModalNewTaskWidget extends StatefulWidget {
  const ShowModalNewTaskWidget({super.key});

  @override
  State<ShowModalNewTaskWidget> createState() => _ShowModalNewTaskWidgetState();
}

class _ShowModalNewTaskWidgetState extends State<ShowModalNewTaskWidget> {
  /// Form key for input validation.
  final _formKey = GlobalKey<FormState>();

  /// Controllers & focus nodes for fields.
  final _titleController = TextEditingController();
  final _titleScrollController = ScrollController();
  final _titleFocusNode = FocusNode();

  final _descriptionController = TextEditingController();
  final _descriptionScrollController = ScrollController();
  final _descriptionFocusNode = FocusNode();

  /// Selected task category (excluding "all").
  TaskCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();

    // Automatically focus title field when modal appears.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks.
    _titleController.dispose();
    _titleScrollController.dispose();
    _titleFocusNode.dispose();

    _descriptionController.dispose();
    _descriptionScrollController.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  /// Simple validation for empty fields.
  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не може бути порожнім';
    }
    return null;
  }

  /// Handles "Create" button tap.
  ///
  /// Steps:
  /// 1. Validate form fields.
  /// 2. Ensure category is selected.
  /// 3. Build [TaskDomain] entity.
  /// 4. Dispatch event to BLoC.
  Future<void> _onCreatePressed() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    final selectedCategory = _selectedCategory;

    if (selectedCategory == null) {
      await DialogHelper.showErrorDialog(context, message: 'Будь ласка, виберіть категорію');
      return;
    }

    if (!isValid) return;

    final task = TaskDomain.create(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: selectedCategory,
    );

    context.read<TaskBloc>().add(TaskAddEvent(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) async {
        if (state is TaskSuccessState) {
          // Close modal and return "true" to parent screen.
          context.pop(true);
        } else if (state is TaskErrorState) {
          await DialogHelper.showErrorDialog(context, message: 'Не вдалося додати');
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.colorGraphite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: GestureDetector(
          // Dismiss keyboard on background tap.
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Builder(
                builder: (context) {
                  final viewInsetsBottom = MediaQuery.viewInsetsOf(context).bottom;

                  return SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20 + viewInsetsBottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text('Нове завдання', style: AppTextStyle.semibold16, textAlign: TextAlign.center),
                        ),
                        const Divider(thickness: 1.2, color: AppColors.colorPureWhite),

                        const SizedBox(height: 12),
                        const Text('Заголовок', style: AppTextStyle.regular16),
                        const SizedBox(height: 6),

                        /// Title field
                        TextFieldWidget(
                          controller: _titleController,
                          scrollController: _titleScrollController,
                          hintText: 'Додати назву завдання',
                          focusNode: _titleFocusNode,
                          nextFocusNode: _descriptionFocusNode,
                          validator: validateField,
                        ),

                        const SizedBox(height: 12),
                        const Text('Опис', style: AppTextStyle.regular16),
                        const SizedBox(height: 6),

                        /// Description field
                        TextFieldWidget(
                          controller: _descriptionController,
                          scrollController: _descriptionScrollController,
                          hintText: 'Додати опис',
                          focusNode: _descriptionFocusNode,
                          validator: validateField,
                        ),

                        const SizedBox(height: 12),
                        const Text('Категорія', style: AppTextStyle.regular16),
                        const SizedBox(height: 6),

                        /// Category selector
                        AppDropdown<TaskCategory>(
                          value: _selectedCategory,
                          hint: 'Оберіть категорію',
                          items: TaskCategory.values
                              .where((e) => e != TaskCategory.all)
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.title,
                                    style: AppTextStyle.regular16.copyWith(color: AppColors.colorPureWhite),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(() => _selectedCategory = value),
                        ),

                        const SizedBox(height: 20),

                        /// Action buttons row
                        _RowButtonsWidget(onCreatePressed: _onCreatePressed),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of "Cancel" and "Create" buttons.
///
/// Extracted into its own widget for readability.
class _RowButtonsWidget extends StatelessWidget {
  const _RowButtonsWidget({required this.onCreatePressed});

  final VoidCallback? onCreatePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Cancel button
        Expanded(
          child: ButtonWidget(
            title: 'Скасувати',
            textStyle: AppTextStyle.regular16,
            onPressed: () => context.pop(),
            backgroundColor: AppColors.colorGraphite,
            foregroundColor: AppColors.colorAzureBlueDark,
            side: const BorderSide(color: AppColors.colorAzureBlueDark),
          ),
        ),

        const SizedBox(width: 22),

        /// Create button
        Expanded(
          child: ButtonWidget(
            title: 'Створити',
            textStyle: AppTextStyle.regular16.copyWith(color: AppColors.colorPureWhite),
            onPressed: onCreatePressed,
            backgroundColor: AppColors.colorAzureBlue,
            foregroundColor: AppColors.colorPureWhite,
          ),
        ),
      ],
    );
  }
}
