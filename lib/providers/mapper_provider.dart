import 'package:flutter/material.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class MapperProvider extends ChangeNotifier {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int i) {
    _tabIndex = i;
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  TaskStatus? _statusFilter;
  TaskStatus? get statusFilter => _statusFilter;

  TaskPriority? _priorityFilter;
  TaskPriority? get priorityFilter => _priorityFilter;

  bool _sortBySoonest = true;
  bool get sortBySoonest => _sortBySoonest;

  double _radius = 5;
  double get radius => _radius;

  double? _latitude;
  double? get latitude => _latitude;
  double? _longitude;
  double? get longitude => _longitude;
  bool _gpsAcquired = false;
  bool get gpsAcquired => _gpsAcquired;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  bool _autoSyncWifi = true;
  bool get autoSyncWifi => _autoSyncWifi;

  String _gpsAccuracy = 'High';
  String get gpsAccuracy => _gpsAccuracy;

  String _photoCompression = 'Standard';
  String get photoCompression => _photoCompression;

  bool _saveOriginalPhotos = false;
  bool get saveOriginalPhotos => _saveOriginalPhotos;

  bool _pushNotifications = true;
  bool get pushNotifications => _pushNotifications;

  bool _approvalAlerts = true;
  bool get approvalAlerts => _approvalAlerts;

  bool _isCallActive = false;
  bool get isCallActive => _isCallActive;

  String? _activeConversationId;
  String? get activeConversationId => _activeConversationId;

  final UserProfile _profile = const UserProfile();
  UserProfile get profile => _profile;

  List<Task> _tasks = [];
  List<Task> get tasks => _filteredTasks();

  List<Vendor> _vendors = [];
  List<Vendor> get vendors => _vendors;

  List<NotificationItem> _notifications = [];
  List<NotificationItem> get notifications => _notifications;

  List<Conversation> _conversations = [];
  List<Conversation> get conversations => _conversations;

  Map<String, List<Message>> _messages = {};
  List<Message> messages(String conversationId) =>
      _messages[conversationId] ?? [];

  List<Report> _reports = [];
  List<Report> get reports => _reports;

  MapperStats get stats => const MapperStats();

  List<MarketCoverage> get marketCoverage => [
        MarketCoverage(name: 'Central', percentage: 35, color: AppColors.marketCentral),
        MarketCoverage(name: 'Downtown', percentage: 28, color: AppColors.marketDowntown),
        MarketCoverage(name: 'Westside', percentage: 22, color: AppColors.marketWestside),
        MarketCoverage(name: 'Eastside', percentage: 15, color: AppColors.marketEastside),
      ];

  DailySummary get dailySummary => const DailySummary();

  MapperProvider() {
    _initMockData();
  }

  void _initMockData() {
    _tasks = [
      Task(id: 'T-001', title: 'Register Tech Emporium', vendorName: 'Tech Emporium', market: 'Central Market', dueDate: DateTime.now().add(const Duration(days: 1)), status: TaskStatus.inProgress, priority: TaskPriority.high, description: 'New electronics vendor registration', requiredActions: ['Collect Business Info', 'Update Photos', 'Map GPS Location']),
      Task(id: 'T-002', title: 'Map Mama Mboga Greens', vendorName: 'Mama Mboga Greens', market: 'Downtown Market', dueDate: DateTime.now().add(const Duration(days: 2)), status: TaskStatus.pending, priority: TaskPriority.medium, description: 'Map fresh produce vendor location'),
      Task(id: 'T-003', title: 'Verify Spice Corner', vendorName: 'Spice Corner', market: 'Westside Market', dueDate: DateTime.now().add(const Duration(days: 3)), status: TaskStatus.completed, priority: TaskPriority.low, completedAt: DateTime.now().subtract(const Duration(hours: 5)), description: 'Verify spice vendor registration'),
      Task(id: 'T-004', title: 'Register Fashion Hub', vendorName: 'Fashion Hub', market: 'Eastside Market', dueDate: DateTime.now().add(const Duration(days: 4)), status: TaskStatus.requiresFix, priority: TaskPriority.high, rejectionReason: 'Photos are blurry and business name is incorrect. Please retake photos and verify business registration.', description: 'Clothing vendor registration needs corrections', requiredActions: ['Retake Photos', 'Verify Business Name']),
      Task(id: 'T-005', title: 'Map Hardware Tools', vendorName: 'Hardware Tools Ltd', market: 'Central Market', dueDate: DateTime.now().add(const Duration(days: 5)), status: TaskStatus.pending, priority: TaskPriority.medium, description: 'Map hardware store'),
      Task(id: 'T-006', title: 'Register Fresh Bites', vendorName: 'Fresh Bites Café', market: 'Downtown Market', dueDate: DateTime.now().add(const Duration(days: 2)), status: TaskStatus.pending, priority: TaskPriority.high, description: 'New café registration'),
      Task(id: 'T-007', title: 'Verify Bookworm Haven', vendorName: 'Bookworm Haven', market: 'Central Market', dueDate: DateTime.now().add(const Duration(days: 6)), status: TaskStatus.completed, priority: TaskPriority.low, completedAt: DateTime.now().subtract(const Duration(days: 1)), description: 'Bookstore verification'),
      Task(id: 'T-008', title: 'Map Green Pharmacy', vendorName: 'Green Pharmacy', market: 'Westside Market', dueDate: DateTime.now().add(const Duration(days: 3)), status: TaskStatus.requiresFix, priority: TaskPriority.medium, rejectionReason: 'GPS coordinates inaccurate. Please re-map the location with better accuracy.', requiredActions: ['Re-map GPS Location']),
      Task(id: 'T-009', title: 'Register Smart Electronics', vendorName: 'Smart Electronics', market: 'Eastside Market', dueDate: DateTime.now().add(const Duration(days: 7)), status: TaskStatus.inProgress, priority: TaskPriority.high, description: 'Electronics vendor', requiredActions: ['Collect Business Info', 'Update Photos']),
      Task(id: 'T-010', title: 'Verify Daily Bread Bakery', vendorName: 'Daily Bread Bakery', market: 'Downtown Market', dueDate: DateTime.now().add(const Duration(days: 8)), status: TaskStatus.pending, priority: TaskPriority.low, description: 'Bakery verification'),
    ];

    _vendors = [
      Vendor(id: 'V-001', businessName: 'Tech Emporium', ownerName: 'John Kamau', category: 'Electronics', phone: '+254 723 456 789', email: 'john@techemporium.co.ke', market: 'Central Market', shopNumber: 'C-12', registrationNumber: 'REG-2024-001', taxId: 'TIN-123456', operatingHours: '8:00 AM - 8:00 PM', employeeCount: 5, latitude: -1.2833, longitude: 36.8167, accuracy: 3.2, status: VendorStatus.pending, submissionDate: DateTime.now().subtract(const Duration(days: 2))),
      Vendor(id: 'V-002', businessName: 'Mama Mboga Greens', ownerName: 'Grace Wanjiku', category: 'Fresh Produce', phone: '+254 734 567 890', email: 'grace@greens.co.ke', market: 'Downtown Market', shopNumber: 'D-05', registrationNumber: 'REG-2024-002', taxId: 'TIN-234567', operatingHours: '6:00 AM - 6:00 PM', employeeCount: 2, latitude: -1.2860, longitude: 36.8200, accuracy: 2.1, status: VendorStatus.pending, submissionDate: DateTime.now().subtract(const Duration(days: 1))),
      Vendor(id: 'V-003', businessName: 'Spice Corner', ownerName: 'Ali Hassan', category: 'Spices & Herbs', phone: '+254 745 678 901', email: 'ali@spicecorner.co.ke', market: 'Westside Market', shopNumber: 'W-08', registrationNumber: 'REG-2024-003', taxId: 'TIN-345678', operatingHours: '7:00 AM - 9:00 PM', employeeCount: 3, latitude: -1.2900, longitude: 36.8100, accuracy: 1.5, status: VendorStatus.approved, submissionDate: DateTime.now().subtract(const Duration(days: 5))),
      Vendor(id: 'V-004', businessName: 'Fashion Hub', ownerName: 'Susan Nyambura', category: 'Clothing & Fashion', phone: '+254 756 789 012', email: 'susan@fashionhub.co.ke', market: 'Eastside Market', shopNumber: 'E-03', registrationNumber: 'REG-2024-004', taxId: 'TIN-456789', operatingHours: '9:00 AM - 8:00 PM', employeeCount: 4, latitude: -1.2780, longitude: 36.8250, accuracy: 5.0, status: VendorStatus.rejected, submissionDate: DateTime.now().subtract(const Duration(days: 3)), rejectionNote: 'Blurry photos and incorrect business registration number. Please retake and verify.'),
      Vendor(id: 'V-005', businessName: 'Hardware Tools Ltd', ownerName: 'Peter Kimani', category: 'Hardware', phone: '+254 767 890 123', email: 'peter@hardwaretools.co.ke', market: 'Central Market', shopNumber: 'C-07', registrationNumber: 'REG-2024-005', taxId: 'TIN-567890', operatingHours: '7:00 AM - 7:00 PM', employeeCount: 6, latitude: -1.2840, longitude: 36.8175, accuracy: 2.8, status: VendorStatus.pending, submissionDate: DateTime.now().subtract(const Duration(days: 1))),
    ];

    _notifications = [
      NotificationItem(id: 'N-001', type: NotificationType.assignment, title: 'New Task Assigned', body: 'You have been assigned to register Tech Emporium at Central Market.', timestamp: DateTime.now().subtract(const Duration(hours: 2)), isRead: false),
      NotificationItem(id: 'N-002', type: NotificationType.approval, title: 'Vendor Approved', body: 'Spice Corner has been approved successfully.', timestamp: DateTime.now().subtract(const Duration(hours: 5)), isRead: false),
      NotificationItem(id: 'N-003', type: NotificationType.rejection, title: 'Submission Rejected', body: 'Fashion Hub registration has been rejected. Please review comments.', timestamp: DateTime.now().subtract(const Duration(hours: 8)), isRead: true),
      NotificationItem(id: 'N-004', type: NotificationType.system, title: 'Weekly Report Ready', body: 'Your weekly performance report is ready for review.', timestamp: DateTime.now().subtract(const Duration(days: 1)), isRead: true),
      NotificationItem(id: 'N-005', type: NotificationType.assignment, title: 'Priority Task', body: 'Fresh Bites Café registration is due in 2 days.', timestamp: DateTime.now().subtract(const Duration(days: 1)), isRead: false),
      NotificationItem(id: 'N-006', type: NotificationType.system, title: 'Offline Mode Available', body: 'You are in a low-connectivity area. Enable offline mode to continue working.', timestamp: DateTime.now().subtract(const Duration(days: 2)), isRead: true),
      NotificationItem(id: 'N-007', type: NotificationType.approval, title: 'Map Point Approved', body: 'Your mapping of Hardware Tools Ltd has been approved.', timestamp: DateTime.now().subtract(const Duration(days: 2)), isRead: true),
      NotificationItem(id: 'N-008', type: NotificationType.rejection, title: 'Correction Needed', body: 'Green Pharmacy mapping needs correction. GPS coordinates are inaccurate.', timestamp: DateTime.now().subtract(const Duration(days: 3)), isRead: true),
    ];

    _conversations = [
      Conversation(id: 'C-001', name: 'Admin Support', avatar: 'AS', lastMessage: 'Your query has been resolved.', lastTime: '2m ago', unreadCount: 1, isOnline: true),
      Conversation(id: 'C-002', name: 'Tech Emporium', avatar: 'TE', lastMessage: 'We open at 8 AM daily', lastTime: '1h ago', unreadCount: 2, isOnline: false),
      Conversation(id: 'C-003', name: 'Admin Approvals', avatar: 'AA', lastMessage: 'Please review the pending submissions', lastTime: '3h ago', unreadCount: 0, isOnline: true),
      Conversation(id: 'C-004', name: 'Team Lead', avatar: 'TL', lastMessage: 'Great work this week!', lastTime: '1d ago', unreadCount: 0, isOnline: true),
      Conversation(id: 'C-005', name: 'Spice Corner', avatar: 'SC', lastMessage: 'Thank you for the visit!', lastTime: '2d ago', unreadCount: 0, isOnline: false),
    ];

    _messages = {
      'C-001': [
        Message(id: 'M-001', senderId: 'support', senderName: 'Admin Support', content: 'Hello! How can I help you today?', timestamp: DateTime.now().subtract(const Duration(hours: 2)), isMe: false),
        Message(id: 'M-002', senderId: 'me', senderName: 'You', content: 'Hi, I have an issue with the GPS sync on my device.', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 2)), isMe: true),
        Message(id: 'M-003', senderId: 'support', senderName: 'Admin Support', content: 'Please try restarting the GPS and ensure location permissions are enabled.', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 5)), isMe: false),
        Message(id: 'M-004', senderId: 'me', senderName: 'You', content: 'That worked, thank you!', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 8)), isMe: true),
        Message(id: 'M-005', senderId: 'support', senderName: 'Admin Support', content: 'Your query has been resolved.', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 10)), isMe: false),
      ],
      'C-002': [
        Message(id: 'M-006', senderId: 'vendor', senderName: 'Tech Emporium', content: 'Hi, when will you visit our shop?', timestamp: DateTime.now().subtract(const Duration(hours: 3)), isMe: false),
        Message(id: 'M-007', senderId: 'me', senderName: 'You', content: 'Hi John, I plan to come by tomorrow morning.', timestamp: DateTime.now().subtract(const Duration(hours: 3)).add(const Duration(minutes: 5)), isMe: true),
        Message(id: 'M-008', senderId: 'vendor', senderName: 'Tech Emporium', content: 'We open at 8 AM daily', timestamp: DateTime.now().subtract(const Duration(hours: 3)).add(const Duration(minutes: 10)), isMe: false),
      ],
      'C-003': [
        Message(id: 'M-009', senderId: 'admin', senderName: 'Admin Approvals', content: 'Please review the pending submissions', timestamp: DateTime.now().subtract(const Duration(hours: 4)), isMe: false),
      ],
      'C-004': [
        Message(id: 'M-010', senderId: 'lead', senderName: 'Team Lead', content: 'Great work this week!', timestamp: DateTime.now().subtract(const Duration(days: 1)), isMe: false),
        Message(id: 'M-011', senderId: 'me', senderName: 'You', content: 'Thank you! Hoping to hit 50 completions.', timestamp: DateTime.now().subtract(const Duration(days: 1)).add(const Duration(minutes: 3)), isMe: true),
      ],
      'C-005': [
        Message(id: 'M-012', senderId: 'vendor', senderName: 'Spice Corner', content: 'Thank you for the visit!', timestamp: DateTime.now().subtract(const Duration(days: 2)), isMe: false),
        Message(id: 'M-013', senderId: 'me', senderName: 'You', content: 'You\'re welcome! Everything looks great.', timestamp: DateTime.now().subtract(const Duration(days: 2)).add(const Duration(minutes: 5)), isMe: true),
      ],
    };

    _reports = [
      Report(id: 'R-001', name: 'Weekly Performance Report - Week 30', date: DateTime.now().subtract(const Duration(days: 1)), size: '2.4 MB'),
      Report(id: 'R-002', name: 'Monthly Summary - June 2026', date: DateTime.now().subtract(const Duration(days: 5)), size: '4.1 MB'),
      Report(id: 'R-003', name: 'Market Coverage Analysis Q2', date: DateTime.now().subtract(const Duration(days: 12)), size: '8.7 MB'),
      Report(id: 'R-004', name: 'Vendor Registration Log - July', date: DateTime.now().subtract(const Duration(days: 2)), size: '1.2 MB'),
    ];

    _toggleRead();
  }

  List<Task> _filteredTasks() {
    var result = List<Task>.from(_tasks);
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result.where((t) =>
          t.title.toLowerCase().contains(q) ||
          t.vendorName.toLowerCase().contains(q) ||
          t.market.toLowerCase().contains(q)).toList();
    }
    if (_statusFilter != null) {
      result = result.where((t) => t.status == _statusFilter).toList();
    }
    if (_priorityFilter != null) {
      result = result.where((t) => t.priority == _priorityFilter).toList();
    }
    if (_sortBySoonest) {
      result.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else {
      result.sort((a, b) => b.dueDate.compareTo(a.dueDate));
    }
    return result;
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  void setStatusFilter(TaskStatus? s) {
    _statusFilter = s;
    notifyListeners();
  }

  void setPriorityFilter(TaskPriority? p) {
    _priorityFilter = p;
    notifyListeners();
  }

  void setSortBySoonest(bool b) {
    _sortBySoonest = b;
    notifyListeners();
  }

  void setRadius(double r) {
    _radius = r;
    notifyListeners();
  }

  void simulateGpsAcquisition() {
    _latitude = -1.2833 + (DateTime.now().millisecondsSinceEpoch % 100) * 0.0001;
    _longitude = 36.8167 + (DateTime.now().millisecondsSinceEpoch % 80) * 0.0001;
    _gpsAcquired = true;
    notifyListeners();
  }

  void setCallActive(bool v) {
    _isCallActive = v;
    notifyListeners();
  }

  void setActiveConversation(String? id) {
    _activeConversationId = id;
    notifyListeners();
  }

  void markNotificationRead(String id) {
    _notifications = _notifications.map((n) =>
        n.id == id ? NotificationItem(id: n.id, type: n.type, title: n.title, body: n.body, timestamp: n.timestamp, isRead: true) : n).toList();
    notifyListeners();
  }

  void markAllNotificationsRead() {
    _notifications = _notifications.map((n) =>
        NotificationItem(id: n.id, type: n.type, title: n.title, body: n.body, timestamp: n.timestamp, isRead: true)).toList();
    notifyListeners();
  }

  void _toggleRead() {}

  void toggleOfflineMode() {
    _isOnline = !_isOnline;
    notifyListeners();
  }

  void toggleAutoSyncWifi() {
    _autoSyncWifi = !_autoSyncWifi;
    notifyListeners();
  }

  void setGpsAccuracy(String v) {
    _gpsAccuracy = v;
    notifyListeners();
  }

  void setPhotoCompression(String v) {
    _photoCompression = v;
    notifyListeners();
  }

  void toggleSaveOriginalPhotos() {
    _saveOriginalPhotos = !_saveOriginalPhotos;
    notifyListeners();
  }

  void togglePushNotifications() {
    _pushNotifications = !_pushNotifications;
    notifyListeners();
  }

  void toggleApprovalAlerts() {
    _approvalAlerts = !_approvalAlerts;
    notifyListeners();
  }

  void sendMessage(String conversationId, String content) {
    final list = List<Message>.from(_messages[conversationId] ?? []);
    list.add(Message(
      id: 'M-${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me',
      senderName: 'You',
      content: content,
      timestamp: DateTime.now(),
      isMe: true,
    ));
    _messages[conversationId] = list;
    notifyListeners();
  }

  int get unreadNotificationCount =>
      _notifications.where((n) => !n.isRead).length;

  int get activeTaskCount =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;

  List<Task> get todayPriorityTasks {
    final now = DateTime.now();
    return _tasks.where((t) =>
        t.priority == TaskPriority.high &&
        t.status != TaskStatus.completed &&
        t.dueDate.isAfter(now.subtract(const Duration(days: 1))) &&
        t.dueDate.isBefore(now.add(const Duration(days: 3)))).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<Task> get requiresFixTasks =>
      _tasks.where((t) => t.status == TaskStatus.requiresFix).toList();

  List<Task> get completedTasks {
    return _tasks.where((t) => t.status == TaskStatus.completed).toList()
      ..sort((a, b) {
        if (a.completedAt == null && b.completedAt == null) return 0;
        if (a.completedAt == null) return 1;
        if (b.completedAt == null) return -1;
        return b.completedAt!.compareTo(a.completedAt!);
      });
  }

  List<Task> get rejectedTasks {
    return _tasks.where((t) => t.status == TaskStatus.requiresFix).toList();
  }

  int get tasksCompleted => _tasks.where((t) => t.status == TaskStatus.completed).length;
  int get tasksInProgress => _tasks.where((t) => t.status == TaskStatus.inProgress).length;
  int get tasksPendingReview => _tasks.where((t) => t.status == TaskStatus.pending).length + _tasks.where((t) => t.status == TaskStatus.requiresFix).length;
  double get performanceRating {
    final total = _tasks.length;
    if (total == 0) return 0;
    return (_tasks.where((t) => t.status == TaskStatus.completed).length / total) * 100;
  }
}
