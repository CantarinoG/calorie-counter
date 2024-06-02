class DateFormatter {
  DateFormatter();

  String getMonthName(int monthNumber) {
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[monthNumber - 1];
  }

  String formatDate(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    return '${getMonthName(month)} ${day.toString()}, ${year.toString()}';
  }
}
