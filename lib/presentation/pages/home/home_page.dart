import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_scutum_test/di/injector.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_category.dart';
import 'package:flutter_space_scutum_test/domain/entities/enums/task_status.dart';
import 'package:flutter_space_scutum_test/domain/entities/task_domain.dart';
import 'package:flutter_space_scutum_test/presentation/blocs/task/task_bloc.dart';
import 'package:flutter_space_scutum_test/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_space_scutum_test/presentation/pages/common/dialogs/dialog_helper.dart';
import 'package:flutter_space_scutum_test/presentation/pages/common/show_modal/show_modal_new_task_widget.dart';
import 'package:flutter_space_scutum_test/presentation/pages/home/home_router.dart';
import 'package:flutter_space_scutum_test/resources/app_colors.dart';
import 'package:flutter_space_scutum_test/resources/app_text_style.dart';
import 'package:flutter_space_scutum_test/widget/button/filter_button_widget.dart';
import 'package:flutter_space_scutum_test/widget/card/task_card_widget.dart';
import 'package:flutter_space_scutum_test/widget/scaffold_widget.dart';
import 'package:go_router/go_router.dart';

/// Main page displaying the list of tasks.
///
/// Responsibilities:
/// - load tasks on page open
/// - navigate to weather screen
/// - open modal to create a new task
/// - show filtered task list
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // Load tasks after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TasksBloc>().add(const TasksLoadEvent());
    });
  }

  /// Opens the bottom sheet to add a new task.
  ///
  /// If the modal returns `true`, it means a new task was successfully created,
  /// so the page reloads tasks.
  Future<void> _onAddPressed(BuildContext context) async {
    final isSuccessful = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return BlocProvider(create: (context) => inject<TaskBloc>(), child: const ShowModalNewTaskWidget());
      },
    );

    if (isSuccessful == true) {
      if (!context.mounted) return;
      context.read<TasksBloc>().add(const TasksLoadEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      /// Show dialog on load failure.
      listener: (context, state) async {
        if (state is TasksErrorState) {
          await DialogHelper.showErrorDialog(context, message: 'Не вдалося завантажити дані');
        }
      },
      child: ScaffoldWidget(
        appBar: AppBar(
          backgroundColor: AppColors.colorGraphite,
          title: const Text('Список завдань', style: AppTextStyle.medium18),
          centerTitle: true,
          actions: [
            /// Navigate to weather page.
            IconButton(
              onPressed: () {
                context.push(HomeRouter.weatherPage);
              },
              icon: const Icon(Icons.cloud),
              color: AppColors.colorPureWhite,
            ),
          ],
        ),

        /// FAB for creating a new task.
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddPressed(context),
          backgroundColor: AppColors.colorAzureBlueDark,
          child: const Icon(Icons.add, color: AppColors.colorPureWhite),
        ),

        body: const _BodyWidget(),
      ),
    );
  }
}

/// Wrapper widget containing task filters and task list.
///
/// Uses slivers for flexible scrolling layout.
class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// Filters (category + status)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const _SectionTitleWidget('Категорія:'),
              const SizedBox(height: 6),
              const _FilterCategoryWidget(),
              const SizedBox(height: 20),
              const _SectionTitleWidget('Статус:'),
              const SizedBox(height: 6),
              const _FilterStatusWidget(),
            ]),
          ),
        ),

        /// Task list
        const SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16), sliver: _TasksWidget()),
      ],
    );
  }
}

/// Simple text title displayed above filter blocks.
class _SectionTitleWidget extends StatelessWidget {
  const _SectionTitleWidget(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyle.regular16);
  }
}

/// Horizontal filter buttons reused for categories and status filters.
///
/// Displays buttons like chips with scroll.
class _FilterButtonsHorizontal extends StatelessWidget {
  const _FilterButtonsHorizontal({required this.items, required this.selectedIndex, required this.onSelected});

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          items.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FilterButtonWidget(
              text: items[index],
              isSelected: selectedIndex == index,
              onTap: () => onSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}

/// Category filter connected to [TasksBloc].
class _FilterCategoryWidget extends StatelessWidget {
  const _FilterCategoryWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TasksBloc>();
    final state = bloc.state;

    const categories = TaskCategory.values;
    final selectedIndex = categories.indexOf(state.filterCategory);

    return _FilterButtonsHorizontal(
      items: categories.map((e) => e.title).toList(),
      selectedIndex: selectedIndex,
      onSelected: (index) {
        bloc.add(TasksSetCategoryFilterEvent(category: categories[index]));
      },
    );
  }
}

/// Status filter connected to [TasksBloc].
class _FilterStatusWidget extends StatelessWidget {
  const _FilterStatusWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TasksBloc>();
    final state = bloc.state;

    const statuses = TaskStatus.values;
    final selectedIndex = statuses.indexOf(state.filterStatus);

    return _FilterButtonsHorizontal(
      items: statuses.map((e) => e.title).toList(),
      selectedIndex: selectedIndex,
      onSelected: (index) {
        bloc.add(TasksSetStatusFilterEvent(status: statuses[index]));
      },
    );
  }
}

/// Main widget rendering task list OR loading/error placeholders.
class _TasksWidget extends StatelessWidget {
  const _TasksWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
        }

        final tasks = state.tasks;

        return tasks.isEmpty ? const _EmptyTasksSliver() : _TasksList(tasks: tasks);
      },
    );
  }
}

/// Sliver list containing task cards.
class _TasksList extends StatelessWidget {
  const _TasksList({required this.tasks});

  final List<TaskDomain> tasks;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final task = tasks[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TaskCardWidget(
            title: task.title,
            description: task.description,
            category: task.category.title,
            isCompleted: task.isCompleted,

            /// Toggle isCompleted state.
            onToggleComplete: () {
              final updated = task.copyWith(isCompleted: !task.isCompleted);
              context.read<TasksBloc>().add(TasksUpdateTaskEvent(task: updated));
            },

            /// Delete task.
            onDelete: () {
              context.read<TasksBloc>().add(TasksDeleteTaskEvent(id: task.id));
            },
          ),
        );
      }, childCount: tasks.length),
    );
  }
}

/// Placeholder displayed when the task list is empty.
class _EmptyTasksSliver extends StatelessWidget {
  const _EmptyTasksSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: Text(
          'Схоже, список порожній. Додайте завдання',
          style: AppTextStyle.light14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
