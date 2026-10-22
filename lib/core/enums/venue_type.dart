enum VenueType {
  weddingVenue('Wedding'),
  conferenceVenue('Conference'),
  partyVenue('Party'),
  restaurant('Restaurant'),
  outdoorVenue('Outdoor'),
  accommodation('Accommodation'),
  other('Other');

  const VenueType(this.label);

  final String label;

  @override
  String toString() => label;
}
