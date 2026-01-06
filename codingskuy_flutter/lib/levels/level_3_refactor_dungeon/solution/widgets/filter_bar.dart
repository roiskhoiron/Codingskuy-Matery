import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String filterStatus;
  final Function(String) onFilterChanged;

  const FilterBar({
    super.key,
    required this.filterStatus,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text('Filter: '),
          const SizedBox(width: 8),
          FilterChip(label: 'All', status: 'all', selectedStatus: filterStatus, onSelected: onFilterChanged),
          const SizedBox(width: 8),
          FilterChip(label: 'Completed', status: 'completed', selectedStatus: filterStatus, onSelected: onFilterChanged),
          const SizedBox(width: 8),
          FilterChip(label: 'Pending', status: 'pending', selectedStatus: filterStatus, onSelected: onFilterChanged),
        ],
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final String status;
  final String selectedStatus;
  final Function(String) onSelected;

  const FilterChip({
    super.key,
    required this.label,
    required this.status,
    required this.selectedStatus,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedStatus == status,
      onSelected: (selected) {
        if (selected) onSelected(status);
      },
    );
  }
}
