import 'package:get/get.dart';

class TransactionModel {
  final String id;
  final String memberName;
  final String planName;
  final double amount;
  final DateTime date;
  final String status; // 'Paid', 'Pending', 'Overdue'

  TransactionModel({
    required this.id,
    required this.memberName,
    required this.planName,
    required this.amount,
    required this.date,
    required this.status,
  });
}

class FinanceController extends GetxController {
  final isLoading = false.obs;

  // Stats
  final totalRevenue = 0.0.obs;
  final outstandingPayments = 0.0.obs;
  final activeMemberships = 0.obs;

  // Filters
  final searchQuery = ''.obs;
  final statusFilter = 'All'.obs;

  // Data
  final allTransactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFinances();
  }

  void _loadFinances() async {
    isLoading.value = true;
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800)); 

    // Mock stats
    totalRevenue.value = 15240.0;
    outstandingPayments.value = 2100.0;
    activeMemberships.value = 142;

    // Mock transactions
    allTransactions.addAll([
      TransactionModel(id: 'TXN-001', memberName: 'John Doe', planName: 'Pro Annual', amount: 299.99, date: DateTime.now().subtract(const Duration(days: 1)), status: 'Paid'),
      TransactionModel(id: 'TXN-002', memberName: 'Sarah Smith', planName: 'Basic Monthly', amount: 29.99, date: DateTime.now().subtract(const Duration(days: 2)), status: 'Pending'),
      TransactionModel(id: 'TXN-003', memberName: 'Mike Johnson', planName: 'Premium 6-Month', amount: 159.99, date: DateTime.now().subtract(const Duration(days: 3)), status: 'Overdue'),
      TransactionModel(id: 'TXN-004', memberName: 'Emily Davis', planName: 'Basic Monthly', amount: 29.99, date: DateTime.now().subtract(const Duration(days: 4)), status: 'Paid'),
      TransactionModel(id: 'TXN-005', memberName: 'Robert Wilson', planName: 'Pro Annual', amount: 299.99, date: DateTime.now().subtract(const Duration(days: 5)), status: 'Paid'),
      TransactionModel(id: 'TXN-006', memberName: 'Lisa Brown', planName: 'Premium 6-Month', amount: 159.99, date: DateTime.now().subtract(const Duration(days: 6)), status: 'Pending'),
    ]);

    isLoading.value = false;
  }

  List<TransactionModel> get filteredTransactions {
    return allTransactions.where((txn) {
      final matchesSearch = txn.memberName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                            txn.id.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesStatus = statusFilter.value == 'All' || txn.status == statusFilter.value;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  int get filteredTransactionsCount => filteredTransactions.length;
  int get totalTransactionsCount => allTransactions.length;
}
