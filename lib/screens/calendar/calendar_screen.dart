import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/components/calendar/day_countdown_list.dart';
import 'package:marquer/components/calendar/day_event_list.dart';
import 'package:marquer/components/calendar/day_plan_list.dart';
import 'package:marquer/components/calendar/week_view/week_view.dart';
import 'package:marquer/providers/calendar/calendar_focused_month_provider.dart';
import 'package:marquer/providers/calendar/calendar_overview_provider.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/calendar/calendar_view_mode_provider.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/colors.dart';
import 'package:marquer/utils/format.dart';

enum _Tab { calendar, countdown, plans }

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  _Tab _tab = _Tab.calendar;

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final selectedDate = ref.watch(calendarSelectedDateProvider);
    final focusedMonth = ref.watch(calendarFocusedMonthProvider);
    final overviewAsync = ref.watch(calendarOverviewProvider);

    final datesWithIncomplete = overviewAsync.asData?.value.datesWithIncomplete ?? {};
    final datesWithPlans = overviewAsync.asData?.value.datesWithPlans ?? {};
    final countdownsAsync = ref.watch(countdownsProvider);
    final countdownDates = <String>{
      for (final c in countdownsAsync.asData?.value ?? []) c.targetDate,
    };

    final viewMode = ref.watch(calendarViewModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          if (_tab == _Tab.calendar)
            IconButton(
              icon: Icon(
                viewMode == CalendarViewMode.week
                    ? Icons.calendar_view_month
                    : Icons.view_week_outlined,
              ),
              onPressed: () => ref.read(calendarViewModeProvider.notifier).toggle(),
            ),
          SegmentedButton<_Tab>(
            segments: const [
              ButtonSegment(value: _Tab.calendar, icon: Icon(Icons.calendar_month)),
              ButtonSegment(value: _Tab.countdown, icon: Icon(Icons.timer_outlined)),
              ButtonSegment(value: _Tab.plans, icon: Icon(Icons.checklist_outlined)),
            ],
            selected: {_tab},
            onSelectionChanged: (val) => setState(() => _tab = val.first),
            showSelectedIcon: false,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        layoutBuilder: (currentChild, previousChildren) => Stack(
          fit: StackFit.expand,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: KeyedSubtree(
          key: ValueKey(_tab),
          child: switch (_tab) {
            _Tab.calendar => viewMode == CalendarViewMode.week
              ? const WeekView()
              : _buildCalendarView(colors, selectedDate, focusedMonth, datesWithIncomplete, datesWithPlans, countdownDates),
            _Tab.countdown => _buildCountdownView(),
            _Tab.plans => _buildPlansView(),
          },
        ),
      ),
      floatingActionButton: _tab == _Tab.calendar
          ? null
          : FloatingActionButton(
              onPressed: _tab == _Tab.countdown ? _showAddCountdownSheet : _navigateToAddPlan,
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildCalendarView(
    ColorScheme colors,
    DateTime selectedDate,
    DateTime focusedMonth,
    Set<String> datesWithIncomplete,
    Set<String> datesWithPlans,
    Set<String> countdownDates,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.refresh(calendarOverviewProvider.future),
          ref.refresh(countdownsProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2100),
              focusedDay: focusedMonth,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
              onDaySelected: (selected, focused) {
                ref.read(calendarSelectedDateProvider.notifier).select(selected);
                ref.read(calendarFocusedMonthProvider.notifier).set(focused);
              },
              onPageChanged: (focused) {
                ref.read(calendarFocusedMonthProvider.notifier).set(focused);
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, _) {
                  final key = formatDate(day);
                  final hasTask = datesWithIncomplete.contains(key);
                  final hasCountdown = countdownDates.contains(key);
                  final hasPlan = datesWithPlans.contains(key);
                  if (!hasTask && !hasCountdown && !hasPlan) return null;
                  return Positioned(
                    bottom: 4,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasTask)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (hasCountdown)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (hasPlan)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) => _DayCell(
                  day: day,
                  background: colors.primary.withValues(alpha: 0.15),
                  textColor: colors.primary,
                ),
                selectedBuilder: (context, day, focusedDay) => _DayCell(
                  day: day,
                  background: colors.primary,
                  textColor: colors.onPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                DateFormat('EEEE, MMMM d').format(selectedDate),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const DayEventList(),
            const DayCountdownList(),
            const DayPlanList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownView() {
    final countdownsAsync = ref.watch(countdownsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(countdownsProvider.future),
      child: countdownsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Failed to load countdowns')),
        data: (countdowns) {
          if (countdowns.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Center(child: Text('No countdowns yet')),
              ),
            );
          }

          final pinned = countdowns.firstWhere(
            (c) => c.isPinned,
            orElse: () => countdowns.reduce(
              (a, b) => DateTime.parse(a.targetDate).isBefore(DateTime.parse(b.targetDate)) ? a : b,
            ),
          );
          final rest = countdowns.where((c) => c.id != pinned.id).toList();
          final listKey = countdowns.map((c) => c.id).join(',');

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Column(
                key: ValueKey(listKey),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroCountdownCard(
                    countdown: pinned,
                    onTap: () => context.push('/countdown/detail', extra: pinned),
                    onLongPress: () => _onLongPressCountdown(pinned),
                  ),
                  if (rest.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rest.length,
                      itemBuilder: (context, index) => _CountdownListTile(
                        countdown: rest[index],
                        onTap: () => context.push('/countdown/detail', extra: rest[index]),
                        onLongPress: () => _onLongPressCountdown(rest[index]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlansView() {
    final plansAsync = ref.watch(plansProvider);
    final colors = getColors(context);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(plansProvider.future),
      child: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Failed to load plans')),
        data: (plans) {
          if (plans.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Center(child: Text('No plans yet')),
              ),
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Opacity(
                opacity: plan.isActive ? 1.0 : 0.5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(plan.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plan.schedule.label, style: TextStyle(color: colors.primary, fontSize: 12)),
                        Text(
                          '${plan.tasks.length} task${plan.tasks.length != 1 ? 's' : ''}',
                          style: TextStyle(color: colors.onSurface.withValues(alpha: 0.6), fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () => _navigateToEditPlan(plan),
                    onLongPress: () => _onLongPressPlan(plan),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _onLongPressCountdown(Countdown countdown) async {
    await HapticFeedback.mediumImpact();
    if (!mounted) return;

    final isPinned = countdown.isPinned;
    final result = await showAppActionSheet(context, [
      const AppAction(value: 'edit', icon: Icons.edit_outlined, label: 'Edit'),
      AppAction(
        value: 'pin',
        icon: isPinned ? Icons.push_pin_outlined : Icons.push_pin,
        label: isPinned ? 'Unpin' : 'Pin',
      ),
      const AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
    ]);

    if (!mounted || result == null) return;

    switch (result) {
      case 'edit':
        if (mounted) _showEditCountdownSheet(countdown);
      case 'pin':
        ref.read(countdownsProvider.notifier).togglePin(countdown);
      case 'delete':
        ref.read(countdownsProvider.notifier).delete(countdown);
    }
  }

  Future<void> _onLongPressPlan(Plan plan) async {
    await HapticFeedback.mediumImpact();
    if (!mounted) return;

    final result = await showAppActionSheet(context, [
      const AppAction(value: 'edit', icon: Icons.edit_outlined, label: 'Edit'),
      AppAction(
        value: 'toggle',
        icon: plan.isActive ? Icons.pause_circle_outline : Icons.play_circle_outline,
        label: plan.isActive ? 'Deactivate' : 'Activate',
      ),
      const AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
    ]);

    if (!mounted || result == null) return;

    switch (result) {
      case 'edit':
        if (mounted) _navigateToEditPlan(plan);
      case 'toggle':
        ref.read(plansProvider.notifier).toggleActive(plan);
      case 'delete':
        ref.read(plansProvider.notifier).delete(plan);
    }
  }

  Future<void> _showAddCountdownSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountdownFormSheet(
        onSave: (name, targetDate) {
          ref.read(countdownsProvider.notifier).add(name, targetDate);
        },
      ),
    );
  }

  Future<void> _showEditCountdownSheet(Countdown countdown) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountdownFormSheet(
        initialName: countdown.name,
        initialDate: DateTime.parse(countdown.targetDate),
        onSave: (name, targetDate) {
          ref.read(countdownsProvider.notifier).edit(
            countdown,
            UpdateCountdownRequest(name: name, targetDate: targetDate),
          );
        },
      ),
    );
  }

  void _navigateToAddPlan() {
    context.push('/calendar/plan/form');
  }

  void _navigateToEditPlan(Plan plan) {
    context.push('/calendar/plan/form', extra: plan);
  }
}

int _daysUntil(String targetDate) {
  final target = DateTime.parse(targetDate);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return target.difference(today).inDays;
}

String _daysLabel(int days) {
  if (days > 0) return '$days days';
  if (days == 0) return 'Today';
  return '${-days} days ago';
}

class _HeroCountdownCard extends ConsumerWidget {
  final Countdown countdown;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _HeroCountdownCard({required this.countdown, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = _daysUntil(countdown.targetDate);
    final isPast = days < 0;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Opacity(
        opacity: isPast ? 0.6 : 1.0,
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 220,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/timer_bg/${countdown.bgImage}',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      countdown.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _daysLabel(days),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 6, color: Colors.black87)],
                      ),
                    ),
                  ],
                ),
              ),
              if (countdown.isPinned)
                const Positioned(
                  top: 12,
                  right: 12,
                  child: Icon(Icons.push_pin, color: Colors.white, size: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownListTile extends StatelessWidget {
  final Countdown countdown;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _CountdownListTile({required this.countdown, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final days = _daysUntil(countdown.targetDate);
    final isPast = days < 0;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Opacity(
        opacity: isPast ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                child: Image.asset(
                  'assets/timer_bg/${countdown.bgImage}',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      countdown.name,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _daysLabel(days),
                      style: TextStyle(
                        fontSize: 13,
                        color: isPast ? colors.onSurface.withValues(alpha: 0.5) : colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownFormSheet extends StatefulWidget {
  final String? initialName;
  final DateTime? initialDate;
  final void Function(String name, String targetDate) onSave;

  const _CountdownFormSheet({
    this.initialName,
    this.initialDate,
    required this.onSave,
  });

  @override
  State<_CountdownFormSheet> createState() => _CountdownFormSheetState();
}

class _CountdownFormSheetState extends State<_CountdownFormSheet> {
  late final TextEditingController _nameController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _selectedDate == null) return;
    Navigator.pop(context);
    widget.onSave(name, formatDate(_selectedDate!));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditing = widget.initialName != null;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  isEditing ? 'Edit Countdown' : 'Add Countdown',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Countdown name'),
                  onSubmitted: (_) => _pickDate(),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: Text(
                    _selectedDate == null
                        ? 'Pick a date'
                        : DateFormat('MMMM d, yyyy').format(_selectedDate!),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _save,
                  child: Text(isEditing ? 'Save' : 'Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final DateTime day;
  final Color background;
  final Color textColor;

  const _DayCell({required this.day, required this.background, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(shape: BoxShape.circle, color: background),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
