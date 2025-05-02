import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentOrdersScreen extends ConsumerStatefulWidget {
  const RecentOrdersScreen({super.key});

  @override
  ConsumerState<RecentOrdersScreen> createState() => _RecentOrdersScreenState();
}

class _RecentOrdersScreenState extends ConsumerState<RecentOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Recent Orders Screen Here"),
    );
  }
}
