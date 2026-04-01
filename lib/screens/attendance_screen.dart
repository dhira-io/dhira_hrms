import 'dart:async';
import '../providers/auth_provider.dart';
import '../providers/bottom_nav_provider.dart';
import '../providers/login_provider.dart';
import '../providers/profile_provider.dart';
import '../services/api_service.dart';
import 'ProfileScreen.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';
import 'package:dhira_hrms/providers/attendance_provider.dart';
import 'package:dhira_hrms/providers/popup_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_menu_provider.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:dhira_hrms/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dhira_hrms/screens/timesheet_list_screen.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> with SingleTickerProviderStateMixin {

  bool showCalendar = true;
  var userfullname;
  var useremail;
  var empid;
  var cookieHeader;
  var department;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  Timer? _clockTimer;
  String _currentTimeStr = '';

  @override
  void initState() {
    super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
      getdata().then((value) {
        _fetchInitialData();
      });
   });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Start live clock
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final formatted = DateFormat('HH:mm:ss').format(now);
      setState(() {
        _currentTimeStr = formatted;
      });
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userfullname = prefs.getString('userfullname') ?? "";
    useremail = prefs.getString('useremail') ?? "";
    empid = prefs.getString('empid') ?? "";
    department = prefs.getString('department') ?? "";
  }

  Future<void> _fetchInitialData() async {
    final prov = Provider.of<AttendanceProvider>(context, listen: false);

    // Call your provider methods
    await prov.loadlastLogs(empid);
    // await prov.fetchCalendar(
    //   employee: empid,
    //   fromDate: Utils.getFirstDayOfMonth(),
    //   toDate: Utils.getLastDayOfMonth(),
    // );
    prov.fetchCalendarForMonth(
      employee: empid,
      year: prov.currentYear,
      month: prov.currentMonth,
    );
  }

  void _showAnimatedMainMenu(BuildContext context) {
    final mainMenuProvider =
    Provider.of<PopupMenuProvider>(context, listen: false);
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => mainMenuProvider.closeMenu(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            // Dimmed background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) => Opacity(
                  opacity: _fadeAnimation.value * 0.4,
                  child: Container(color: Colors.black54),
                ),
              ),
            ),

            // Popup content below AppBar
            Positioned(
              top: kToolbarHeight + MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Material(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _popupItem(context, 'Calendar', Icons.calendar_month,
                                  () {
                                mainMenuProvider.closeMenu();
                                Provider.of<BottomNavProvider>(context, listen: false)
                                    .changeIndex(1);
                              }),
                          _popupItem(context, 'Timesheet', Icons.access_time, () {
                            mainMenuProvider.closeMenu();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => TimesheetListScreen()),
                            );
                          }),
                          // _popupItem(
                          //     context, 'Leaders Board', Icons.leaderboard, () {
                          //   mainMenuProvider.closeMenu();
                          // }),
                          // _popupItem(context, 'Announcements', Icons.campaign,
                          //         () {
                          //       mainMenuProvider.closeMenu();
                          //     }),
                          // _popupItem(context, 'Documents', Icons.description, () {
                          //   mainMenuProvider.closeMenu();
                          // }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(overlayEntry);
    _controller.forward();

    mainMenuProvider.addListener(() async {
      if (!mainMenuProvider.isMenuOpen) {
        await _controller.reverse();
        overlayEntry.remove();
      }
    });
  }
  void _showProfilePopup(BuildContext context) {
    final profileProvider =
    Provider.of<ProfileMenuProvider>(context, listen: false);
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: kToolbarHeight + MediaQuery.of(context).padding.top,
        right: 10,
        child: Material(
          color: Colors.white,
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _popupItem(context, 'My Profile', Icons.person, () {
                  profileProvider.closeMenu();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()));
                }),
                _popupItem(context, 'Change Password', Icons.password, () {
                  profileProvider.closeMenu();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()));
                }),
                _popupItem(context, 'Sign Out', Icons.logout, () async {
                  final authProv = context.read<AuthProvider>();
                  final profileProvider = context.read<ProfileMenuProvider>();

                  if (authProv.isMicrosoftLogin) {
                    // If user logged in via Microsoft
                    await authProv.mslogout();
                  } else {
                    // Normal login flow via LoginProvider
                    final loginProvider = context.read<LoginProvider>();
                    await loginProvider.logout();
                  }

                  if (!mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                  );

                  profileProvider.closeMenu();
                }),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    profileProvider.addListener(() {
      if (!profileProvider.isProfileMenuOpen) {
        overlayEntry.remove();
      }
    });
  }
  Widget _popupItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    final now = DateTime.now();
    final currentdate = DateFormat('EEEE, MMMM d, yyyy').format(now);
    final currenttime = _currentTimeStr.isNotEmpty ? _currentTimeStr : DateFormat('HH:mm:ss').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
        backgroundColor: AppColors.white,
        elevation: 5,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none,size: 30,)),
          const SizedBox(width: 10,),
          // Profile section with popup
          Consumer<ProfileMenuProvider>(
            builder: (context, profileProvider, _) {
              final authProv = Provider.of<AuthProvider>(context);
              final profileProv = Provider.of<ProfileProvider>(context);

              return GestureDetector(
                onTap: () {
                  if (profileProvider.isProfileMenuOpen) {
                    profileProvider.closeMenu();
                  } else {
                    profileProvider.openMenu();
                    _showProfilePopup(context);
                  }
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      // Check if state is loaded AND userImage is available
                      backgroundImage: profileProv.state == ProfileState.loaded && profileProv.profile?.userImage != null
                          ? NetworkImage(ApiService.baseUrl + profileProv.profile!.userImage!)
                          : const AssetImage('assets/profile.png') as ImageProvider, // Default image
                      radius: 20,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      profileProvider.isProfileMenuOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 10,),
          Consumer<PopupMenuProvider>(
            builder: (context, mainMenuProvider, _) {
              return IconButton(
                icon: Icon(
                  mainMenuProvider.isMenuOpen ? Icons.close : Icons.menu,
                  size: 30,
                  color: Colors.black87,
                ),
                onPressed: () {
                  if (mainMenuProvider.isMenuOpen) {
                    mainMenuProvider.closeMenu();
                  } else {
                    mainMenuProvider.openMenu();
                    _showAnimatedMainMenu(context);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: provider.loadingStatus  == AttendanceProviderStatus.Loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'Attendance',
              style: TextStyle(
                color: const Color(0xFF1F2937),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                color: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(currentdate, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(currenttime, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      Visibility(
                        visible: provider.punchedIn,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xffD1FAE5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,  // Ensure row only takes needed width
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF059669),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('Present', style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.w500,fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton.icon(
              onPressed: () async {
                if (!provider.isPunching) {
                  // If currently false, user wants to punch in; if true, punch out
                  if (provider.punchedIn) {
                    await provider.punchOut(empid);
                  } else {
                    await provider.punchIn(empid);
                  }
                }
              },
              icon: Icon(
                provider.icon,
                color: provider.isPunching
                    ? const Color(0xFF1000CC)
                    : provider.textColor,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.buttonColor,
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              label: Text(provider.punchedIntext,style: TextStyle(fontSize: 16,
                  color: provider.isPunching
                  ? const Color(0xFF1000CC)
                  : provider.textColor, fontWeight: FontWeight.w600),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Attendance Log",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF0FF), // single background color (light blue)
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Calendar Icon
                      Container(
                        decoration: BoxDecoration(
                          color: showCalendar ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.calendar_month,
                            color: showCalendar ? AppColors.primaryBlue : AppColors.grey400,
                          ),
                          onPressed: () {
                            setState(() {
                              showCalendar = true;
                            });
                          },
                        ),
                      ),

                      // List Icon
                      Container(
                        decoration: BoxDecoration(
                          color: !showCalendar ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.list,
                            color: !showCalendar ? AppColors.primaryBlue : AppColors.grey400,
                          ),
                          onPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // The view (calendar or log)
          Expanded(
            child: showCalendar ? _buildCalendarView() : _buildLogView(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return Consumer<AttendanceProvider>(
      builder: (context, prov, child) {
        if (prov.isLoadingCalendar) {
          return const Center(child: CircularProgressIndicator());
        }
        if (prov.calendarError != null) {
          return Center(child: Text(prov.calendarError!));
        }

        int days = prov.daysInMonth;
        int year = prov.currentYear;
        int month = prov.currentMonth;

        DateTime firstOfMonth = DateTime(year, month, 1);
        int weekdayOfFirst = firstOfMonth.weekday;
        int offset = weekdayOfFirst % 7;

        String monthName = _monthName(month);
        String monthYearLabel = "$monthName $year";

        List<String> weekdayLabels = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
        int totalSlots = offset + days;

        return SingleChildScrollView( // ✅ Prevent unbounded height
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: AppColors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 4),
                      // Header row with arrows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              int newMonth = month - 1;
                              int newYear  = year;
                              if (newMonth < 1) {
                                newMonth = 12;
                                newYear  = year - 1;
                              }
                              prov.fetchCalendarForMonth(
                                employee: empid,
                                year: newYear,
                                month: newMonth,
                              );
                            },
                          ),
                          Text(
                            monthYearLabel,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              int newMonth = month + 1;
                              int newYear  = year;
                              if (newMonth > 12) {
                                newMonth = 1;
                                newYear  = year + 1;
                              }
                              prov.fetchCalendarForMonth(
                                employee: empid,
                                year: newYear,
                                month: newMonth,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: weekdayLabels
                            .map((wd) =>
                            Expanded(child: Center(child: Text(wd))))
                            .toList(),
                      ),
                      const SizedBox(height: 4),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true, // ✅ Important
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: totalSlots,
                        itemBuilder: (context, index) {
                          if (index < offset) return const SizedBox.shrink();
                          int day = index - offset + 1;
                          String? status = prov.statusForDay(day);
                          return DayCircle(day: day, status: status);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Center(child: _buildLegend()),
              ),
            ],
          ),
        );
      },
    );
  }

// Helper: month number → name
  String _monthName(int month) {
    const List<String> names = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    if (month >= 1 && month <= 12) {
      return names[month - 1];
    } else {
      return "";
    }
  }

  Widget _buildLogView() {
    return Consumer<AttendanceProvider>(
      builder: (context, prov, child) {
        if (prov.isLoadingLogs) {
          return const Center(child: CircularProgressIndicator());
        }
        if (prov.logsError != null) {
          return Center(child: Text(prov.logsError!));
        }
        if (prov.logs.isEmpty) {
          return const Center(child: Text("No log records"));
        }

        return ListView.builder(
          itemCount: prov.logs.length,
          itemBuilder: (context, index) {
            final log = prov.logs[index];
            return Card(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xffEDE9FE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(log.monthAbbr, style: const TextStyle(color: Color(0xff4F46E5), fontWeight: FontWeight.bold),),
                          Text(log.dayNumber, style: const TextStyle(color: Color(0xff4F46E5), fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: log.status == "Weekend"
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(log.dayName, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                          const Text("Weekend", style: TextStyle(color: Colors.red)),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(log.dayName, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              if(log.inTime != null) Text(Utils.convertDatetoTime(log.inTime!)),
                              Text(" - "),
                              if(log.outTime != null) Text(Utils.convertDatetoTime(log.outTime!)),

                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (log.workingHours != null)
                          Text('${log.workingHours!.toStringAsFixed(1)}h',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Legend widget
  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _legendDot(label: "Present", color: const Color(0xFFD1FAE5), borderColor: Color(0xFF059669))),
          const SizedBox(width: 8),
          Expanded(child: _legendDot(label: "Holiday", color: const Color(0xFFFEF3C7), borderColor: Color(0xFFF59E0B))),
          const SizedBox(width: 8),
          Expanded(child: _legendDot(label: "Leave", color: const Color(0xFFFCE7F3), borderColor: Color(0xFFDB2777))),
        ],
      ),
    );
  }

  Widget _legendDot({required String label, required Color color, required Color borderColor,}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.5),

          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Inter',)),
      ],
    );
  }

}

// A small widget for the day circle
class DayCircle extends StatelessWidget {
  final int day;
  final String? status;

  const DayCircle({
    Key? key,
    required this.day,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool highlight = status != null;

    // Replace with your AppColors
    Color bgColor = Colors.transparent;
    Color borderColor = Colors.transparent;
    Color textColor = Colors.black87;

    if (highlight) {
      switch (status!.trim().toLowerCase()) {
        case 'present':
          bgColor = Color(0xffD1FAE5);
          borderColor = Color(0xffD1FAE5);
          textColor = Color(0xFF059669);
          break;
        case 'holiday':
          bgColor = Color(0xffFEF3C7);
          borderColor = Color(0xffFEF3C7);
          textColor = Color(0xFFF59E0B);
          break;
        case 'on leave':
          bgColor = Color(0xffFEE2E2);
          borderColor = Color(0xffFEE2E2);
          textColor = Color(0xFFDC2626);
          break;
        case 'leave':
          bgColor = Color(0xffFEE2E2);
          borderColor = Color(0xffFEE2E2);
          textColor = Color(0xFFDC2626);
          break;
        case 'absent':
          bgColor = Colors.red.withOpacity(0.3);
          borderColor = Colors.red;
          textColor = Colors.red;
          break;
        case 'half day':
          bgColor = Colors.yellow.withOpacity(0.3);
          borderColor = Colors.yellow.shade700;
          textColor = Colors.yellow.shade700;
          break;
        default:
          bgColor = Colors.grey.withOpacity(0.2);
          borderColor = Colors.grey;
          textColor = Colors.grey;
      }
    }

    return Container(
      margin: const EdgeInsets.all(8),
      child: Center(
        child: Container(
          width: 39,
          height: 36,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: highlight
                ? Border.all(color: borderColor, width: 1.5)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            day.toString(),
            style: TextStyle(color: textColor,fontSize: 14,fontFamily: 'Inter',
              fontWeight: FontWeight.w500,),
          ),
        ),
      ),
    );
  }
}
