/// The top-level service categories from the original app's home.
///
/// Verified live against the API:
/// - City buses for EVERY city live at operationType=2 (op=1 is always empty).
///   e.g. HYDERABAD op=2 → 1106 routes (CITY ORDINARY, METRO EXPRESS, VAJRA…).
/// - Airport = same query + isAirport=true (HYD has 5).
/// - District = statewide intercity services (NO cityId): SUPER LUXURY,
///   RAJADHANI, GARUDA, LAHARI sleepers… (2998). Not tied to the chosen city.
enum ServiceCategory {
  city(
    label: 'City',
    operationType: 2,
    isAirport: false,
    cityScoped: true,
  ),
  district(
    label: 'District',
    operationType: 2,
    isAirport: false,
    cityScoped: false, // statewide intercity — ignores selected city
  ),
  airport(
    label: 'Airport',
    operationType: 2,
    isAirport: true,
    cityScoped: true,
  );

  const ServiceCategory({
    required this.label,
    required this.operationType,
    required this.isAirport,
    required this.cityScoped,
  });

  final String label;
  final int operationType;
  final bool isAirport;

  /// Whether this category filters by the selected city. District does not.
  final bool cityScoped;
}
