import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';
import 'package:market_mirror_mobile/screens/mapper/task_detail/task_detail_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Tasks', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilterSheet(context, provider),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            color: AppColors.surface,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: GoogleFonts.inter(color: AppColors.textHint),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          provider.setSearchQuery('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: GoogleFonts.inter(fontSize: 14),
              onChanged: provider.setSearchQuery,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: AppColors.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _FilterChip(label: 'All', selected: provider.statusFilter == null, onTap: () => provider.setStatusFilter(null)),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Pending', selected: provider.statusFilter == TaskStatus.pending, onTap: () => provider.setStatusFilter(TaskStatus.pending)),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'In Progress', selected: provider.statusFilter == TaskStatus.inProgress, onTap: () => provider.setStatusFilter(TaskStatus.inProgress)),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Completed', selected: provider.statusFilter == TaskStatus.completed, onTap: () => provider.setStatusFilter(TaskStatus.completed)),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Requires Fix', selected: provider.statusFilter == TaskStatus.requiresFix, onTap: () => provider.setStatusFilter(TaskStatus.requiresFix)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: provider.tasks.isEmpty
                ? _EmptyTasksState(filter: provider.statusFilter, search: provider.searchQuery)
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.tasks.length,
                    itemBuilder: (_, i) => _TaskCard(task: provider.tasks[i]),
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context, MapperProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _FilterSheet(provider: provider),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: selected ? Colors.white : AppColors.textSecondary, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  final MapperProvider provider;
  const _FilterSheet({required this.provider});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late TaskPriority? _selectedPriority;
  late bool _sortSoonest;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.provider.priorityFilter;
    _sortSoonest = widget.provider.sortBySoonest;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filter & Sort', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Text('Priority', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              _PriorityOption(label: 'All', selected: _selectedPriority == null, onTap: () => setState(() => _selectedPriority = null)),
              const SizedBox(width: 8),
              _PriorityOption(label: 'High', selected: _selectedPriority == TaskPriority.high, color: AppColors.priorityHigh, onTap: () => setState(() => _selectedPriority = TaskPriority.high)),
              const SizedBox(width: 8),
              _PriorityOption(label: 'Medium', selected: _selectedPriority == TaskPriority.medium, color: AppColors.priorityMedium, onTap: () => setState(() => _selectedPriority = TaskPriority.medium)),
              const SizedBox(width: 8),
              _PriorityOption(label: 'Low', selected: _selectedPriority == TaskPriority.low, color: AppColors.priorityLow, onTap: () => setState(() => _selectedPriority = TaskPriority.low)),
            ],
          ),
          const SizedBox(height: 20),
          Text('Sort by Due Date', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              _SortOption(label: 'Soonest First', selected: _sortSoonest, onTap: () => setState(() => _sortSoonest = true)),
              const SizedBox(width: 8),
              _SortOption(label: 'Latest First', selected: !_sortSoonest, onTap: () => setState(() => _sortSoonest = false)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                widget.provider.setPriorityFilter(_selectedPriority);
                widget.provider.setSortBySoonest(_sortSoonest);
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text('Apply Filters', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _PriorityOption extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;
  const _PriorityOption({required this.label, required this.selected, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? (color ?? AppColors.primary).withValues(alpha: 0.1) : AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? (color ?? AppColors.primary) : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...[
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 6),
            ],
            Text(label, style: GoogleFonts.inter(fontSize: 13, color: selected ? AppColors.textPrimary : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SortOption({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryContainer : AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: selected ? AppColors.primary : AppColors.textSecondary, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: taskPriorityColor(task.priority), width: 4)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${task.vendorName} \u2022 ${task.market}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: taskStatusBgColor(task.status),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _statusIcon(task.status),
                      const SizedBox(width: 4),
                      Text(taskStatusLabel(task.status), style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: taskPriorityColor(task.priority))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: task.dueDate.isBefore(DateTime.now()) ? AppColors.error : AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  task.dueDate.isBefore(DateTime.now()) ? 'Overdue: ${formatDate(task.dueDate)}' : 'Due: ${formatDate(task.dueDate)}',
                  style: GoogleFonts.inter(fontSize: 12, color: task.dueDate.isBefore(DateTime.now()) ? AppColors.error : AppColors.textSecondary),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: taskPriorityColor(task.priority).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                  child: Text(taskPriorityLabel(task.priority), style: GoogleFonts.inter(fontSize: 10, color: taskPriorityColor(task.priority), fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            if (task.status == TaskStatus.requiresFix && task.rejectionReason != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, size: 16, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(child: Text(task.rejectionReason!, style: GoogleFonts.inter(fontSize: 11, color: AppColors.error))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task))),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  side: BorderSide(color: task.status == TaskStatus.completed ? AppColors.success : AppColors.primary),
                ),
                child: Text(
                  task.status == TaskStatus.completed ? 'View Details' : 'Start Task',
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending: return const Icon(Icons.schedule, size: 14, color: AppColors.warning);
      case TaskStatus.inProgress: return const Icon(Icons.sync, size: 14, color: AppColors.info);
      case TaskStatus.completed: return const Icon(Icons.check_circle, size: 14, color: AppColors.success);
      case TaskStatus.requiresFix: return const Icon(Icons.error, size: 14, color: AppColors.error);
    }
  }
}

class _EmptyTasksState extends StatelessWidget {
  final TaskStatus? filter;
  final String search;
  const _EmptyTasksState({this.filter, this.search = ''});

  @override
  Widget build(BuildContext context) {
    String message;
    if (search.isNotEmpty) {
      message = 'No tasks matching "$search"';
    } else if (filter != null) {
      message = 'No ${taskStatusLabel(filter!).toLowerCase()} tasks';
    } else {
      message = 'No tasks available';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(message, style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Try adjusting your filters', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint)),
          ],
        ),
      ),
    );
  }
}
