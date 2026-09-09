class DashboardSummary {
  const DashboardSummary({
    required this.venueName,
    required this.occupancyRate,
    required this.revenue,
    required this.activeBookings,
    required this.pendingAlerts,
    required this.lastUpdated,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      venueName: json['venueName'] as String? ?? 'Grand Hall',
      occupancyRate: (json['occupancyRate'] as num?)?.toDouble() ?? 86.4,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 48250,
      activeBookings: json['activeBookings'] as int? ?? 134,
      pendingAlerts: json['pendingAlerts'] as int? ?? 9,
      lastUpdated: json['lastUpdated'] as String? ?? 'Just now',
    );
  }

  final String venueName;
  final double occupancyRate;
  final double revenue;
  final int activeBookings;
  final int pendingAlerts;
  final String lastUpdated;

  Map<String, dynamic> toJson() {
    return {
      'venueName': venueName,
      'occupancyRate': occupancyRate,
      'revenue': revenue,
      'activeBookings': activeBookings,
      'pendingAlerts': pendingAlerts,
      'lastUpdated': lastUpdated,
    };
  }
}
