import 'dart:async';
import 'package:dhira_hrms/model/leave_list_model.dart';
import 'package:dhira_hrms/providers/auth_provider.dart';
import 'package:dhira_hrms/providers/leave_provider.dart';
import 'package:dhira_hrms/providers/login_provider.dart';
import 'package:dhira_hrms/providers/popup_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_menu_provider.dart';
import 'package:dhira_hrms/screens/timesheet_list_screen.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/bottom_nav_provider.dart';
import '../providers/profile_provider.dart';
import '../services/api_service.dart';
import 'ProfileScreen.dart';
import 'apply_leave_screen.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';
import 'package:intl/intl.dart';

class LeaveListScreen extends StatefulWidget {
  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> with SingleTickerProviderStateMixin {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  late FocusNode _focusNode;

  String? userfullname;
  String? useremail;
  String? empid;
  String department = "";
  String leaveapprovername = "";

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitial();
    });

    _scrollController.addListener(() {
      final provider = Provider.of<LeaveProvider>(context, listen: false);
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100 &&
          !provider.isFetchingMore &&
          provider.hasMoreData) {
        provider.loadLeaveApplications();
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

  Future<void> _loadInitial() async {
    await getdata();
    await Provider.of<LeaveProvider>(context, listen: false)
        .loadLeaveApplications(refresh: true);
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    useremail = prefs.getString('useremail') ?? "";
    empid = prefs.getString('empid') ?? "";
    department = prefs.getString('department') ?? "";
    leaveapprovername  = prefs.getString('leaveapprovername') ?? '';
    userfullname = prefs.getString('userfullname') ?? "";

    setState(() {});
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      Provider.of<LeaveProvider>(context, listen: false).applySearch(value);
      // If you prefer server-side search:
      // Provider.of<LeaveProvider>(context, listen: false).searchLeaves(value);
    });
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
            'Are you sure you want to $action this leave?',
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

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final profileProv = Provider.of<ProfileProvider>(context);

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
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
        body: Column(
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
                    'My Leave Applications',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,  // Use the focusNode here
                decoration: InputDecoration(
                  hintText: 'Search…',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<LeaveProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.errorMessage != null) {
                    return Center(child: Text('Error: ${provider.errorMessage!}'));
                  }
                  if (provider.items.isEmpty) {
                    return Center(child: Text('No leave applications found'));
                  }

                  // Determine item count with loader / end message slot
                  int itemCount = provider.items.length
                      + (provider.isFetchingMore ? 1 : 0)
                      + ((!provider.hasMoreData && !provider.isFetchingMore) ? 1 : 0);

                  return RefreshIndicator(
                    onRefresh: () async {
                      await provider.loadLeaveApplications(refresh: true);
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {

                        if (index < provider.items.length) {
                       final LeaveListModel leave = provider.items[index];

                       // print("====>emp id =${leave.employee} mail = $empid");

                       return Card(
                         color: AppColors.white,
                         margin: const EdgeInsets.symmetric(
                             horizontal: 12, vertical: 8),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("ID", FontWeight.w700),
                                   titlename(leave.name, FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("Employee", FontWeight.w700),
                                   titlename(leave.employeeName, FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("Type", FontWeight.w700),
                                   titlename(leave.leaveType, FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("From Date", FontWeight.w700),
                                   titlename(DateFormat('dd-MM-yyyy').format(DateTime.parse(leave.fromDate)), FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("To Date", FontWeight.w700),
                                   titlename(DateFormat('dd-MM-yyyy').format(DateTime.parse(leave.toDate)), FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("Total leave days", FontWeight.w700),
                                   titlename(leave.totalleavedays.toString(), FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("Status", FontWeight.w700),
                                   titlename(leave.status, FontWeight.w400),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   titlename("Approver", FontWeight.w700),
                                   titlename(leave.leaveapproverName ?? "-",
                                       FontWeight.w400),
                                 ],
                               ),


                               const SizedBox(height: 8),
                               if (leave.docstatus == 0 && leave.employee == empid && leave.status == "Open") ...[
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     ElevatedButton.icon(
                                       onPressed: () async {
                                         bool confirm = await _showConfirmationDialog(context, "delete");
                                         if (confirm) {
                                           await provider.deleteLeave(leave.name);
                                           _loadInitial();
                                         }
                                         },
                                       icon: const Icon(
                                           Icons.delete_forever, size: 18,
                                           color: AppColors.white),
                                       label: const Text(
                                         'Delete',
                                         style: TextStyle(fontSize: 16,
                                             color: AppColors.white),
                                       ),
                                       style: ElevatedButton.styleFrom(
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(8),
                                         ),
                                         backgroundColor: AppColors.bgred,
                                       ),
                                     ),
                                     SizedBox(width: 10,),
                                     ElevatedButton.icon(
                                       onPressed: () {
                                         final result = Navigator.push<bool>(
                                           context,
                                           MaterialPageRoute(
                                             builder: (_) =>
                                                 ApplyLeaveScreen(
                                                   leaveId: leave.name,
                                                   employeeName: leave.employeeName,
                                                   leaveapproverName: leave.leaveapproverName
                                                 ),
                                           ),
                                         );
                                         if (result == true) {
                                           _loadInitial();
                                         }
                                       },
                                       icon: const Icon(Icons.edit, size: 18,
                                           color: AppColors.white),
                                       label: const Text(
                                         'Edit',
                                         style: TextStyle(fontSize: 16,
                                             color: AppColors.white),
                                       ),
                                       style: ElevatedButton.styleFrom(
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(8),
                                         ),
                                         backgroundColor: AppColors.primaryBlue,
                                       ),
                                     ),
                                   ],
                                 ),
                               ],
                               if (leave.docstatus == 1 &&
                                   DateTime.tryParse(leave.fromDate)!.isAfter(
                                       DateTime.now())) ...[
                                 Align(
                                   alignment: Alignment.centerRight,
                                   child: ElevatedButton.icon(
                                     onPressed: () async {
                                       bool confirm = await _showConfirmationDialog(context, "cancel");
                                       if (confirm) {
                                         await provider.cancelLeave(leave.name);
                                         _loadInitial();
                                       }
                                     },
                                     icon: const Icon(Icons.cancel, size: 18,
                                         color: AppColors.white),
                                     label: const Text(
                                       'Cancel',
                                       style: TextStyle(
                                           fontSize: 16, color: AppColors.white),
                                     ),
                                     style: ElevatedButton.styleFrom(
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(8),
                                       ),
                                       backgroundColor: AppColors.borderOrange,
                                     ),
                                   ),
                                 ),
                               ],
                               if (leave.leaveapprover?.toLowerCase() ==
                                   useremail && leave.docstatus == 0) ...[
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     ElevatedButton.icon(
                                       onPressed: () {
                                         provider.changeLeaveStatus(
                                           leaveApplicationName: leave.name,
                                           newStatus: 'Rejected',
                                           onSuccess: () {
                                             ScaffoldMessenger
                                                 .of(context)
                                                 .showSnackBar(
                                               const SnackBar(content: Text(
                                                   'Status rejected')),
                                             );
                                             Navigator.of(context).pop(true);
                                           },
                                         );
                                       },
                                       // icon: const Icon(Icons.edit, size: 18, color: AppColors.white),
                                       label: const Text(
                                         'Reject',
                                         style: TextStyle(fontSize: 16,
                                             color: AppColors.white),
                                       ),
                                       style: ElevatedButton.styleFrom(
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(8),
                                         ),
                                         backgroundColor: AppColors.bgred,
                                       ),
                                     ),
                                     SizedBox(width: 10,),
                                     ElevatedButton.icon(
                                       onPressed: () {
                                         provider.changeLeaveStatus(
                                           leaveApplicationName: leave.name,
                                           newStatus: 'Approved',
                                           // or other status
                                           onSuccess: () {
                                             ScaffoldMessenger
                                                 .of(context)
                                                 .showSnackBar(
                                               const SnackBar(content: Text(
                                                   'Status updated successfully')),
                                             );
                                             Navigator.of(context).pop(
                                                 true); // pass true to indicate change
                                           },
                                         );
                                       },
                                       // icon: const Icon(Icons.edit, size: 18, color: AppColors.white),
                                       label: const Text(
                                         'Approve',
                                         style: TextStyle(fontSize: 16,
                                             color: AppColors.white),
                                       ),
                                       style: ElevatedButton.styleFrom(
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(8),
                                         ),
                                         backgroundColor: AppColors.bggreen,
                                       ),
                                     ),
                                   ],
                                 )
                               ],
                             ],
                           ),
                         ),
                       );
                      }
                     else if (provider.isFetchingMore && index == provider.items.length) {
                       return const Padding(
                         padding: EdgeInsets.all(16.0),
                         child: Center(child: CircularProgressIndicator()),
                       );
                     }
                     else {
                       // No more data message
                       return const Padding(
                         padding: EdgeInsets.all(16.0),
                         child: Center(
                           child: Text(
                             "No more leave applications",
                             style: TextStyle(color: Colors.grey),
                           ),
                         ),
                       );
                     }
                     },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          // mini: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ApplyLeaveScreen()),
            ).then((result) {
            if (result == true) {
               _loadInitial();
                }
              });
            },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget titlename(String label, weight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label, style: TextStyle(fontSize: 14, fontWeight: weight)),
    );
  }

}
