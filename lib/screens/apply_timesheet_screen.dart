import 'package:dhira_hrms/screens/timesheet_list_screen.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:dhira_hrms/widgets/mandatory_label.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/singleTimesheet_model.dart';
import '../providers/auth_provider.dart';
import '../providers/bottom_nav_provider.dart';
import '../providers/login_provider.dart';
import '../providers/popup_menu_provider.dart';
import '../providers/profile_menu_provider.dart';
import '../providers/timesheet_provider.dart';
import 'ProfileScreen.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;
  final String? empName;
  final String? empId;
  final String? approverName;
  final String? approverID;

  const ApplyTimesheetScreen({super.key, required this.timesheetId, this.empName, this.approverName, this.empId, this.approverID});

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> with SingleTickerProviderStateMixin {

  final _employeeController = TextEditingController();
  final _departmentController = TextEditingController();
  final _approverController = TextEditingController();
  final  _fromDateController = TextEditingController();
  final  _toDateController = TextEditingController();
  int? approved = 0;
  int? docstatus = 0;
  String? employeeName;
  String? tsApproverName;
  String? tsApproverID;
  String? employeeID;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // List<ProjectAssignments> _localAssignments = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final provider =
      Provider.of<TimesheetProvider>(context, listen: false);
      await _loadUserDataFromPrefs();
      await provider.fetchProjects();

      if (widget.timesheetId != "0") {
        await provider.fetchSingleTimesheets(widget.timesheetId);
        _initializeFields(provider);
      }
      else {
        setState(() {
          _setCurrentWeekDates();
          provider.clearLocalData(); // reset local assignments & summary
        });
      }
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

  Future<void> _loadUserDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    employeeName = prefs.getString('userfullname');
    tsApproverName = prefs.getString('timesheetApprover');

    setState(() {
      employeeID = widget.empId;
      tsApproverID = widget.approverID;
      _employeeController.text = employeeName ?? widget.empName!;
      _departmentController.text = prefs.getString('department') ?? 'Unknown Department';
      _approverController.text = tsApproverName ?? widget.approverName ?? "";
    });
  }

  void _setCurrentWeekDates() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - DateTime.monday));
    final friday = monday.add(const Duration(days: 4));

    final formatter = DateFormat('dd-MM-yyyy');

    setState(() {
      _fromDateController.text = formatter.format(monday);
      _toDateController.text = formatter.format(friday);
    });

    final provider = Provider.of<TimesheetProvider>(context, listen: false);
    provider.setFromDate(monday);
    provider.setToDate(friday);
  }

  @override
  void dispose() {
    _employeeController.dispose();
    _departmentController.dispose();
    _approverController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _initializeFields(TimesheetProvider provider) {
    final data = provider.timesheetData;

    if (data != null) {
      _employeeController.text = (widget.empName != '' ? widget.empName : employeeName)!;// data.employee ?? widget.empName!;
      employeeID = data.employee;
      _departmentController.text = data.organizationDepartment ?? '';
      _approverController.text = data.approverName ?? "-";
      _fromDateController.text = ConvertYeartoDate(data.fromDate);
      _toDateController.text = ConvertYeartoDate(data.toDate);
       approved = data.approved;
       docstatus = data.docstatus;
       print("employeeID ==> $employeeID");
    }
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(),
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

  Future<bool> _showConfirmationDialog(BuildContext context, String action) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Center(
          child: Text(
            'Are you sure you want to $action this timesheet?',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 10,),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              action[0].toUpperCase() + action.substring(1),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ) ?? false;
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

  @override
  Widget build(BuildContext context) {
    return Consumer<TimesheetProvider>(
      builder: (context, provider, child) {
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

          body: provider.isSubmitting
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: EdgeInsets.all(16),
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
                      widget.timesheetId != "0" && widget.timesheetId.isNotEmpty ?
                      Text("Edit Timesheet", style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),) : Text("Apply Timesheet", style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),),
                      SizedBox(width: 20,),

                      Text(docstatus == 0 ? "Draft" : "Saved",style: TextStyle(color: docstatus == 0 ? AppColors.bgred : AppColors.bggreen),),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Employee details (non-editable)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Employee Details", style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),),
                ),
                Card(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MandatoryLabel(labeltext: 'Employee Name'),
                        _buildReadOnlyField("Employee Name", _employeeController),
                        SizedBox(height: 8),
                        Text('Department'),
                        _buildReadOnlyField("Department", _departmentController),
                        SizedBox(height: 8),
                        Text('Approver'),
                        _buildReadOnlyField("Approver", _approverController),
                        SizedBox(height: 12),
                        MandatoryLabel(labeltext: "Note :"),
                        Text("From date should be Monday"),
                        SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(child: MandatoryLabel(labeltext: 'From Date')),
                            SizedBox(width: 20,),
                            Expanded(child: MandatoryLabel(labeltext: 'To Date')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: widget.timesheetId != "0"
                                    ? null
                                    : () async {
                                  // inside your GestureDetector onTap for From Date
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: provider.fromDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    if (picked.weekday != DateTime.monday) {
                                      Fluttertoast.showToast(
                                        msg:
                                        "Selected date is not a Monday. Proceeding anyway.",
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }

                                    final friday = picked.add(Duration(
                                        days: DateTime.friday - picked.weekday));

                                    provider.setFromDate(picked);
                                    provider.setToDate(friday);

                                    setState(() {
                                      _fromDateController.text =
                                          DateFormat('dd-MM-yyyy').format(picked);
                                      _toDateController.text =
                                          DateFormat('dd-MM-yyyy').format(friday);
                                    });
                                  }
                                },
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'From Date',
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                  ),
                                  child: Text(
                                    _fromDateController.text.isNotEmpty
                                        ? _fromDateController.text
                                        : 'Select date',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: GestureDetector(
                                onTap: widget.timesheetId != "0"
                                    ? null
                                    :  () async {
                                  final initial = provider.toDate ?? DateTime.now();
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: initial,
                                    firstDate: provider.fromDate ?? DateTime(2020),
                                    lastDate: provider.fromDate != null ? provider.fromDate!.add(Duration(days: 6)) : DateTime(2100),
                                  );
                                  if (picked != null) {
                                    provider.setToDate(picked);
                                    setState(() {
                                      _toDateController.text = DateFormat('dd-MM-yyyy').format(picked);//picked.toLocal().toString().split(' ')[0];
                                    });
                                  }
                                },
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'To Date',
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                  ),
                                  child: Text(
                                    _toDateController.text.isNotEmpty
                                        ? _toDateController.text
                                        : 'Select date',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // List of project assignment rows
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Project Assignments", style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),),
                ),
                const Divider(),
                provider.localAssignments.isEmpty
                    ? const Padding(padding: EdgeInsets.all(8.0), child: Text('No project assignments yet', style: TextStyle(color: Colors.grey)))
                    : Column(children: provider.localAssignments.asMap().entries.map((e) {
                  final idx = e.key;
                  final p = e.value;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(p.project ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      subtitle: Text('Spent hrs: ${p.spentHours ?? 0}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(icon: const Icon(Icons.edit, color: AppColors.blue,), onPressed: () => _addProjectDialog(existing: p, index: idx)),
                        IconButton(icon: const Icon(Icons.delete,color: AppColors.bgred,), onPressed: () async {
                          final ok = await _showConfirmationDialog(context, 'Delete');
                          if (ok) provider.deleteLocalAssignment(idx);
                        }),
                      ]),
                    ),
                  );
                }).toList()),

                const SizedBox(height: 16),
                // + Add Project & save button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _addProjectDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("+ Add Project",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () async {
                      // Check if assignments list is empty
                        if (provider.localAssignments.isEmpty) {
                          // Show alert dialog to user
                          await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Alert'),
                                content: const Text('Please add at least one project assignment before submitting the timesheet.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              )
                          );
                          // Stop further processing
                          return;
                        }

                        // Step 1: parse it:
                        DateTime fromparsedDate = DateFormat('dd-MM-yyyy').parse(_fromDateController.text);
                        String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromparsedDate);

                        DateTime toparsedDate = DateFormat('dd-MM-yyyy').parse(_toDateController.text);
                        String formattedToDate = DateFormat('yyyy-MM-dd').format(toparsedDate);

                        // Proceed with submit/update logic
                        final success = widget.timesheetId == "0"
                            ? await provider.submitTimesheet(
                          employee: employeeID!,
                          department: _departmentController.text,
                          approver: tsApproverID ?? "",
                          fromDate: formattedFromDate,
                          toDate: formattedToDate,
                          assignments: provider.localAssignments,//_localAssignments,
                          context: context,
                        )
                            : await provider.updateTimesheet(
                          name: widget.timesheetId,
                          employee: employeeID!,
                          department: _departmentController.text,
                          approver: tsApproverID ?? "",
                          approved: approved ?? 0,
                          hours_total: provider.totalHours ?? 0.0,
                          assignments: provider.localAssignments,// _localAssignments,
                          context: context,
                        );

                        if (success && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Timesheet ${widget.timesheetId == "0" ? "submitted" : "updated"} successfully')),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to ${widget.timesheetId == "0" ? "submit" : "update"} timesheet')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(widget.timesheetId == "0" ? "Submit" : "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

               /* if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      provider.errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),*/

                SizedBox(height: 16),
                // Summary Card
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Summary", style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),),
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
                              child: _buildStatTile('Hours Total', provider.totalHours.toStringAsFixed(2)),
                            ),
                          ),
                          SizedBox(
                            width: tileWidth,
                            child: IntrinsicHeight(
                              child: _buildStatTile('Expected Hours', provider.expectedHours.toStringAsFixed(2)),
                            ),
                          ),
                          SizedBox(
                            width: tileWidth,
                            child: IntrinsicHeight(
                              child: _buildStatTile('Remaining Hours', provider.remainingHours.toStringAsFixed(2)),
                            ),
                          ),
                          SizedBox(
                            width: tileWidth,
                            child: IntrinsicHeight(
                              child: _buildStatTile('Spent Hours', provider.spentHours.toStringAsFixed(2)),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _addProjectDialog({ ProjectAssignments? existing, int? index }) async {
    final provider = Provider.of<TimesheetProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();

    String? selectedProject = existing?.project;
    final _dateController        = TextEditingController(text: ConvertYeartoDate(existing?.date) ?? '');
    final _hourDetailController  = TextEditingController(text: existing?.hoursDetails ?? '');
    final _expectedHoursController = TextEditingController(text: existing?.expectedHours?.toString() ?? '');
    final _spentHoursController    = TextEditingController(text: existing?.spentHours?.toString() ?? '');
    final _raisedByController       = TextEditingController(text: prefs.getString('userfullname') ?? '');

    final _formKey = GlobalKey<FormState>();  // ← Added form key

    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.all(16),
                content: SingleChildScrollView(
                  child: Form(              // ← Wrap in Form
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              existing == null ? "Add Timesheet" : "Edit Timesheet",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Text('Project Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Inter')),
                        const SizedBox(height: 8),
                        provider.isLoadingProjects
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownButtonFormField<String>(
                          initialValue: selectedProject,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: "Project Name",
                            border: OutlineInputBorder(),
                          ),
                          items: provider.projects
                              .map((p) => DropdownMenuItem(
                            value: p.name,
                            child: Text(p.projectName),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedProject = value;
                              print("proj name = ${selectedProject}");
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a project';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        Text('Date', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Inter')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () async {
                            await _openDatePicker(context, _dateController);
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: "Date",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () async {
                                await _openDatePicker(context, _dateController);
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please pick a date';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),
                        // Row 1: Labels
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              child: Text(
                                'Expected Hours',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Inter'),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'Spent Hours',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Inter'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
// Row 2: Input Fields
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _expectedHoursController,
                                decoration: const InputDecoration(
                                  hintText: 'Expected hour',
                                  hintStyle: TextStyle(fontSize: 14,),
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  final v = double.tryParse(value);
                                  if (v == null || v <= 0) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  provider.setExpectedHours(double.tryParse(value) ?? 0.0);
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: _spentHoursController,
                                decoration: const InputDecoration(
                                  hintText: 'Spent hour',
                                  hintStyle: TextStyle(fontSize: 14,),
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                ),
                                keyboardType: TextInputType.number,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Required';
                                //   }
                                //   final v = double.tryParse(value);
                                //   if (v == null || v < 0) {
                                //     return 'Invalid';
                                //   }
                                //   return null;
                                // },
                                onChanged: (value) {
                                  provider.setSpentHours(double.tryParse(value) ?? 0.0);
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Text('Hours Details', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Inter')),

                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _hourDetailController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: "Hours Details",
                            border: OutlineInputBorder(),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Hours details cannot be empty';
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(height: 16),

                        Text('Raised By', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Inter')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _raisedByController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: "Raised By",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Raised by cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // 🎯 Run validation
                                if (_formKey.currentState!.validate()) {
                                  DateTime selectedDate = DateFormat('yyyy-MM-dd').parse(_dateController.text);
                                  int compensatoryOff = (selectedDate.weekday == DateTime.saturday || selectedDate.weekday == DateTime.sunday) ? 1 : 0;

                                  DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(_dateController.text);
                                  String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);

                                  final newAssignment = ProjectAssignments(
                                    project: selectedProject,
                                    date: formattedDate,
                                    expectedHours: double.tryParse(_expectedHoursController.text) ?? 0.0,
                                    spentHours: double.tryParse(_spentHoursController.text) ?? 0.0,
                                    raisedBy: prefs.getString('empid'),
                                    completed: 0,
                                    approved: 0,
                                    status: "Pending",
                                    applicableForCompensatoryOff: compensatoryOff,
                                  );

                                  setState(() {
                                    if (existing == null) {
                                      provider.addLocalAssignment(newAssignment);
                                    } else if (index != null) {
                                      print("new assign == $newAssignment");
                                      provider.updateLocalAssignment(index, newAssignment);
                                    }
                                  });

                                  Navigator.pop(context);
                                }
                                // else: validation failed, error messages will appear on fields
                              },
                              child: Text(
                                existing == null ? "Save" : "Update",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<void> _openDatePicker(BuildContext context, TextEditingController _dateController) async {
    try {
      // Parse From and To dates (from main screen)
      final fromDate = DateFormat('dd-MM-yyyy').tryParse(_fromDateController.text) ??
          DateFormat('yyyy-MM-dd').tryParse(_fromDateController.text);
      final toDate = DateFormat('dd-MM-yyyy').tryParse(_toDateController.text) ??
          DateFormat('yyyy-MM-dd').tryParse(_toDateController.text);

      if (fromDate == null || toDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select valid From and To dates first.")),
        );
        return;
      }

      // Determine initial date
      DateTime initialDate = fromDate;
      if (_dateController.text.isNotEmpty) {
        initialDate = DateFormat('dd-MM-yyyy').tryParse(_dateController.text) ??
            DateFormat('yyyy-MM-dd').tryParse(_dateController.text) ??
            fromDate;
      }

      // Clamp initial date between range
      if (initialDate.isBefore(fromDate)) initialDate = fromDate;
      if (initialDate.isAfter(toDate)) initialDate = toDate;

      // ✅ Date picker restricted strictly between fromDate and toDate
      final picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: fromDate,
        lastDate: toDate,
        selectableDayPredicate: (day) {
          // Allow only days between fromDate and toDate
          return !(day.isBefore(fromDate) || day.isAfter(toDate));
        },
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue[800]!,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );

      // Update if user picked a date
      if (picked != null) {
        _dateController.text =
        "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error opening date picker: $e")),
      );
    }
  }

}
