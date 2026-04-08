import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madrasati_plus/colors.dart';

class HorizontalCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const HorizontalCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void didUpdateWidget(HorizontalCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.selectedDate.month != widget.selectedDate.month ||
        oldWidget.selectedDate.year != widget.selectedDate.year) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedDate();
      });
    }
  }

  void _scrollToSelectedDate() {
    final selectedDay = widget.selectedDate.day;
    final selectedIndex = selectedDay - 1;
    final itemWidth = 68.0; 
    final screenWidth = MediaQuery.of(context).size.width;
    
   
    final centerOffset = (screenWidth / 2) - (itemWidth / 2) - 16; 
    final scrollPosition = (selectedIndex * itemWidth) - centerOffset;
    
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        scrollPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _showDatePicker(context),
                  child: 
                      Text(
                        _getMonthYearText(),
                        style: TextStyle(
                          color: blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                     
                 
                  ),
                 const Spacer(),
                 GestureDetector(
                   onTap: () => _changeMonth(-1),
                   behavior: HitTestBehavior.opaque,
                   child: const Icon(
                     Icons.arrow_back_ios,
                     color: blue,
                     size: 16,
                   ),
                 ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () => _changeMonth(1),
                    behavior: HitTestBehavior.opaque,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: blue,
                      size: 16,
                    ),
                  ),
            
              ],
            ),
          ),
          ),
          const SizedBox(height: 16,),
   
        // Calendar Days
        Container(
          height: 80, 
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: _getDaysInCurrentMonth(),
            itemBuilder: (context, index) {
          final day = index + 1;
          final currentDate = DateTime(
            widget.selectedDate.year,
            widget.selectedDate.month,
            day,
          );
          
          final isSelected = widget.selectedDate.day == day;
          
          return GestureDetector(
            onTap: () => widget.onDateSelected(currentDate),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? blue : grayBorder,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: blue.withOpacity(0.35),
                          blurRadius: 14,
                          spreadRadius: 1,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : const [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(currentDate),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$day',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Row(
            children: [
              Text(
                _getAppointmentsLabel(),
                style: TextStyle(
                  color:Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getMonthYearText() {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    final monthName = monthNames[widget.selectedDate.month - 1];
    return '$monthName ${widget.selectedDate.year}';
  }

  void _showDatePicker(BuildContext context) {
    DateTime tempDate = widget.selectedDate;
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onDateSelected(tempDate);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Date Picker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  initialDateTime: widget.selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = DateTime(newDate.year, newDate.month, 1);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeMonth(int delta) {
    int year = widget.selectedDate.year;
    int month = widget.selectedDate.month + delta;

    while (month < 1) {
      month += 12;
      year -= 1;
    }
    while (month > 12) {
      month -= 12;
      year += 1;
    }

    final daysInTargetMonth = _getDaysInMonth(year, month);
    final clampedDay = widget.selectedDate.day.clamp(1, daysInTargetMonth);

    widget.onDateSelected(DateTime(year, month, clampedDay));
  }

  int _getDaysInMonth(int year, int month) {
    switch (month) {
      case 2:
        return _isLeapYear(year) ? 29 : 28;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        return 31;
    }
  }

  int _getDaysInCurrentMonth() {
    final year = widget.selectedDate.year;
    final month = widget.selectedDate.month;
    
    switch (month) {
      case 2: // February
        return _isLeapYear(year) ? 29 : 28;
      case 4: // April
      case 6: // June
      case 9: // September
      case 11: // November
        return 30;
      default:
        return 31;
    }
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  String _getDayName(DateTime date) {
    const dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return dayNames[date.weekday % 7];
  }

  String _getAppointmentsLabel() {
    return 'Appointments · ${_getFullDayName(widget.selectedDate)}, ${_getShortMonthName(widget.selectedDate)} ${widget.selectedDate.day}';
  }

  String _getFullDayName(DateTime date) {
    const dayNames = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];
    return dayNames[date.weekday % 7];
  }

  String _getShortMonthName(DateTime date) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return monthNames[date.month - 1];
  }
}