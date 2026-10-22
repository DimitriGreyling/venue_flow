String getDayOfWeekName(int day) {
  return switch (day) {
    0 => 'Sunday',
    1 => 'Monday',
    2 => 'Tuesday',
    3 => 'Wednesday',
    4 => 'Thursday',
    5 => 'Friday',
    6 => 'Saturday',
    _ => throw ArgumentError.value(day, 'day', 'Must be between 0 and 6'),
  };
}
