import 'package:dhira_hrms/providers/popup_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_menu_provider.dart';
import 'package:dhira_hrms/screens/timesheet_list_screen.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:dhira_hrms/utils/util.dart';
import 'package:dhira_hrms/widgets/mandatory_label.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../providers/bottom_nav_provider.dart';
import '../providers/leave_provider.dart';
import '../providers/login_provider.dart';
import 'ProfileScreen.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';


class ApplyLeaveScreen extends StatefulWidget {

  final String? leaveId; // null = Add mode; non-null = Edit mode
  final String? employeeName; // null = Add mode; non-null = Edit mode
  final String? leaveapproverName; // null = Add mode; non-null = Edit mode

  const ApplyLeaveScreen({Key? key, this.leaveId, this.employeeName, this.leaveapproverName}) : super(key: key);

  @override
  _ApplyLeaveScreenState createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields that may be prefilled
  final _employeeController   = TextEditingController();
  final _departmentController = TextEditingController();
  final _approverController   = TextEditingController();
  final _fromDateController   = TextEditingController();
  final _toDateController     = TextEditingController();
  final _leaveTypeController  = TextEditingController();
  final _reasonController     = TextEditingController();
  late String employeeID;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  late LeaveProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = LeaveProvider();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadUserDataFromPrefs();
      await _provider.getLeaveBalanceAPI(employeeID, Utils.todayDate());

      if (widget.leaveId != null && widget.leaveId != "0") {
        // Edit mode: fetch existing leave data
        await _provider.fetchSingleLeave(widget.leaveId!);
        _initializeFieldsFromProvider();
      } else {
        // Add mode: maybe set default leaveType if provider loads leave types
        _leaveTypeController.text = "Vacation";//_provider.leaveType;
      }

      print("id == ${_employeeController.text}\ndate = ${Utils.todayDate()}");
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
  }

  @override
  void dispose() {
    _employeeController.dispose();
    _departmentController.dispose();
    _approverController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    _leaveTypeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _loadUserDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _employeeController.text   = prefs.getString('userfullname') ?? '';
      employeeID = prefs.getString('empid') ?? '';
      _departmentController.text = prefs.getString('department') ?? '';
      _approverController.text   = prefs.getString('leaveapprovername') ?? '';
    });
  }

  void _initializeFieldsFromProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final d = _provider.leaveData!;

    setState(() {
      _employeeController.text = d.employeeName ?? widget.employeeName!;
      _departmentController.text = d.department ?? '';
      _approverController.text = prefs.getString('leaveapprovername') ??
          widget.leaveapproverName!; // make sure you have this
      _fromDateController.text = ConvertYeartoDate(d.fromDate) ?? '';
      _toDateController.text = ConvertYeartoDate(d.toDate) ?? '';
      _leaveTypeController.text = d.leaveType ?? 'Vacation';
      _reasonController.text = d.description ?? '';
    });

    // Also update provider’s internal state so pickers and logic align
    _provider
      ..fromDate = DateTime.parse(d.fromDate!)
      ..toDate = DateTime.parse(d.toDate!)
      ..isHalfDay = d.halfDay ?? 0;

    if (_provider.isHalfDay == 1 && d.halfDayDate != null) {
      _provider.halfDayDate = DateTime.parse(d.halfDayDate!);
    }
    else {
      _provider.halfDayDate = null;
    }
    _provider.leaveType = d.leaveType ?? '';
    _provider.reason = d.description ?? '';

    // 3. Apply half-day logic based on loaded dates
    if (_provider.fromDate != null && _provider.toDate != null) {
      if (_provider.fromDate!.isAtSameMomentAs(_provider.toDate!)) {
        // If from and to are same → enable half-day
        _provider.isHalfDay = 1;
        _provider.halfDayDate ??= _provider.fromDate;
      } else {
        // Dates differ → no half-day
        _provider.isHalfDay = 0;
        _provider.halfDayDate = null;
      }
    }

    // 4. Trigger UI rebuild
    setState(() {});
  }

  // Helper to convert from "yyyy-MM-dd" -> "dd-MM-yyyy"
  String ConvertYeartoDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    try {
      // Parse the input date
      DateTime parsed = DateFormat("yyyy-MM-dd").parse(dateString);
      // Format to desired output
      return DateFormat("dd-MM-yyyy").format(parsed);
    } catch (e) {
      // If parsing fails, return the original string (or handle error as you like)
      print("Date parse error: $e");
      return dateString;
    }
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
    final isEdit = widget.leaveId != null && widget.leaveId != "0";

    return ChangeNotifierProvider<LeaveProvider>.value(
      value: _provider,
      child: Consumer<LeaveProvider>(
        builder: (context, provider, _) {
          if (isEdit && provider.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Edit Leave'),
                leading: BackButton(),
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }

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
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/profile.png'),
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
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back)),
                          SizedBox(width: 20,),
                          Text(
                            isEdit ? 'Edit Leave' : 'Apply For Leave',
                            style: TextStyle(
                              color: const Color(0xFF1F2937),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Employee Details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Employee Details",
                        style: TextStyle(
                          color: const Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MandatoryLabel(labeltext: 'Employee Name'),
                            TextFormField(
                              controller: _employeeController,
                              enabled: false,
                              decoration: InputDecoration(),
                            ),
                            SizedBox(height: 8),
                            Text('Department'),
                            TextFormField(
                              controller: _departmentController,
                              enabled: false,
                              decoration: InputDecoration(),
                            ),
                            SizedBox(height: 8),
                            Text('Approver'),
                            TextFormField(
                              controller: _approverController,
                              enabled: false,
                              decoration: InputDecoration(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Dates & Reason Section
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Dates & Reason",
                        style: TextStyle(
                          color: const Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Card(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Date pickers row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(child: MandatoryLabel(labeltext: 'From Date')),
                                  SizedBox(width: 20),
                                  Expanded(child: MandatoryLabel(labeltext: 'To Date')),
                                ],
                              ),

                              const SizedBox(height: 6),

                              /// ---- Row 2: Date Fields ----
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _fromDateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Select date', // 👈 No floating label
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        // suffixIcon: const Icon(Icons.calendar_today),
                                        floatingLabelBehavior: FloatingLabelBehavior.never, // disable floating label
                                      ),
                                      onTap: () async {
                                        final picked = await showDatePicker(
                                          context: context,
                                          initialDate: provider.fromDate ?? DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (picked != null) {
                                          provider.setFromDate(picked);
                                          _fromDateController.text =
                                              DateFormat('dd-MM-yyyy').format(picked);
                                          // Reset half-day on date change
                                          //provider.setHalfDay(0);
                                          provider.setHalfDayDate(null);
                                          _toDateController.text = "";

                                        }
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please select from date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _toDateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Select date', // 👈 No floating label
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        // suffixIcon: const Icon(Icons.calendar_today),
                                        floatingLabelBehavior: FloatingLabelBehavior.never, // disable floating label
                                      ),
                                      onTap: () async {
                                        final initial =
                                            provider.toDate ?? provider.fromDate ?? DateTime.now();
                                        final picked = await showDatePicker(
                                          context: context,
                                          initialDate: initial,
                                          firstDate: provider.fromDate ?? DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (picked != null) {
                                          provider.setToDate(picked);
                                          _toDateController.text =
                                              DateFormat('dd-MM-yyyy').format(picked);

                                          // Now check if fromDate and toDate are same calendar day
                                          if (provider.fromDate != null &&
                                              DateUtils.isSameDay(provider.fromDate, picked)) {
                                            // Same day → enable half-day (or leave it up to user)
                                            provider.setHalfDay(1);
                                            // Optionally, auto-set half-day date
                                            provider.setHalfDayDate(provider.fromDate);
                                          } else {
                                            // Different days → reset half-day
                                            provider.setHalfDay(0);
                                            provider.setHalfDayDate(null);
                                          }

                                          // Force UI to rebuild so switch + half-day UI updates
                                          setState(() {});
                                        }
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please select to date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Half-day switch
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Half-day'),
                                  Switch(
                                    value: provider.isHalfDay == 1,
                                    onChanged: (val) {
                                      provider.setHalfDay(val ? 1 : 0); // Update the half day state
                                      setState(() {
                                        if (!val) {
                                          // If the half-day switch is turned off, set halfDayDate to null
                                          provider.setHalfDayDate(null);
                                        } else if (provider.fromDate != null && provider.toDate != null) {
                                          // If both From Date and To Date are the same, set the Half-Day Date to that date
                                          if (provider.fromDate!.isAtSameMomentAs(provider.toDate!)) {
                                            provider.setHalfDayDate(provider.fromDate); // Set the date if From and To are the same
                                          } else {
                                            provider.setHalfDayDate(null);  // If dates are not the same, reset Half-Day Date
                                          }
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              if (provider.isHalfDay == 1) ...[
                                MandatoryLabel(labeltext: 'Select Half-Day Date'),
                                ListTile(
                                  title: Text(
                                    provider.halfDayDate == null
                                        ? (provider.fromDate != null && provider.toDate != null && provider.fromDate!.isAtSameMomentAs(provider.toDate!)
                                        ? DateFormat('dd-MM-yyyy').format(provider.fromDate!)
                                        : 'Select date')
                                        : DateFormat('dd-MM-yyyy').format(provider.halfDayDate!),
                                  ),
                                  trailing: Icon(Icons.calendar_today),
                                  onTap: () async {
                                    if (provider.fromDate == null || provider.toDate == null) {
                                      Fluttertoast.showToast(msg: "Please select fromdate and todate");
                                      return;
                                    }

                                    DateTime first = provider.fromDate!;
                                    DateTime last  = provider.toDate!;
                                    // Choose an initial date that is within [first, last]
                                    // Prefer existing halfDayDate if present, else default to first (or last)
                                    DateTime initial = provider.halfDayDate != null
                                        ? provider.halfDayDate!
                                        : first;

                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: initial,
                                      firstDate: first,
                                      lastDate: last,
                                    );
                                    if (picked != null) {
                                      provider.setHalfDayDate(picked);
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                              SizedBox(height: 8),
                              // Leave type
                              MandatoryLabel(labeltext: 'Leave Type'),
                              TextFormField(
                                controller: _leaveTypeController,
                                enabled: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  // if (val == null || val.isEmpty) return 'Select leave type';
                                  // return null;
                                  _leaveTypeController.text = "Vacation";
                                },
                              ),
                              SizedBox(height: 8),
                              // Reason
                              MandatoryLabel(labeltext: 'Reason'),
                              TextFormField(
                                controller: _reasonController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: null,
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) return 'Please enter reason';
                                  return null;
                                },
                                onChanged: (val) {
                                  provider.setReason(val.trim());
                                },
                                onSaved: (val) {
                                  if (val != null) _provider.setReason(val.trim());
                                },
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Summary
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Summary",
                        style: TextStyle(
                          color: const Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LayoutBuilder(builder: (context, constraints) {
                          final tileWidth = (constraints.maxWidth - 12) / 2;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              SizedBox(
                                width: tileWidth,
                                child: IntrinsicHeight(
                                  child: _buildStatTile('Allocated', provider.totalAllocated.toString()),
                                ),
                              ),
                              SizedBox(
                                width: tileWidth,
                                child: IntrinsicHeight(
                                  child: _buildStatTile('Used', provider.used.toString()),
                                ),
                              ),
                              SizedBox(
                                width: tileWidth,
                                child: IntrinsicHeight(
                                  child: _buildStatTile('Pending', provider.pending.toString()),
                                ),
                              ),
                              SizedBox(
                                width: tileWidth,
                                child: IntrinsicHeight(
                                  child: _buildStatTile('Available', provider.available.toString()),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 16),
                    provider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            // Additional validation for dates
                            if (_fromDateController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select From Date')),
                              );
                              return;
                            }
                            if (_toDateController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select To Date')),
                              );
                              return;
                            }

                            _formKey.currentState!.save();
                            if (isEdit) {
                              await provider.updateLeave(widget.leaveId!);
                            }
                            else {
                              await provider.submit();
                            }
                            if (provider.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(isEdit ? 'Leave updated successfully' : 'Leave applied successfully')),
                              );
                              Navigator.pop(context, true);
                            } else {
                              if (provider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(provider.errorMessage!)),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isEdit ? 'Update' : 'Submit',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Card(
      color: AppColors.white,
      child: Container(
        constraints: BoxConstraints(minHeight: 60),  // ensure at least this height
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Text(label, style: TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,)),
            const SizedBox(height: 4),
            Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
