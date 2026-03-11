import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/components/calendar/countdown_form_sheet.dart';
import 'package:marquer/components/calendar/week_view/week_view.dart';
import 'package:marquer/providers/calendar/calendar_view_mode_provider.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
import 'package:marquer/screens/calendar/views/calendar_month_view.dart';
import 'package:marquer/screens/calendar/views/countdown_tab_view.dart';
import 'package:marquer/screens/calendar/views/plans_tab_view.dart';
import 'package:marquer/utils/action_sheet.dart';

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
          key: ValueKey((_tab, _tab == _Tab.calendar ? viewMode : null)),
          child: switch (_tab) {
            _Tab.calendar => viewMode == CalendarViewMode.week
              ? const WeekView()
              : const CalendarMonthView(),
            _Tab.countdown => CountdownTabView(onLongPress: _onLongPressCountdown),
            _Tab.plans => PlansTabView(onLongPress: _onLongPressPlan, onEdit: _navigateToEditPlan),
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
      builder: (_) => CountdownFormSheet(
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
      builder: (_) => CountdownFormSheet(
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
