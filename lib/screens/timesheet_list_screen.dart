import 'package:dhira_hrms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../providers/bottom_nav_provider.dart';
import '../providers/login_provider.dart';
import '../providers/popup_menu_provider.dart';
import '../providers/profile_menu_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/timesheet_provider.dart';
import '../services/api_service.dart';
import 'ProfileScreen.dart';
import 'apply_timesheet_screen.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';
import 'package:intl/intl.dart';

class TimesheetListScreen extends StatefulWidget {
  const TimesheetListScreen({Key? key}) : super(key: key);

  @override
  State<TimesheetListScreen> createState() => _TimesheetListScreenState();
}

class _TimesheetListScreenState extends State<TimesheetListScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _focusNode;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String userfullname = "";
  String useremail = "";
  String empid = "";
  String department = "";
  String leaveapprovername = "";

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // schedule the fetch after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitial();
    });
    final provider = Provider.of<TimesheetProvider>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100 &&
          provider.hasMore &&
          !provider.isLoadingTimesheets &&
          _searchController.text.trim().isEmpty // only load more when no search
      ) {
        provider.fetchTimesheets();
      }
    });

    _searchController.addListener(() {
      final query = _searchController.text;
      provider.setSearchQuery(query);
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
    Provider.of<TimesheetProvider>(context, listen: false)
        .fetchTimesheets(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userfullname = prefs.getString('userfullname') ?? "";
    useremail = prefs.getString('useremail') ?? "";
    empid = prefs.getString('empid') ?? "";
    department = prefs.getString('department') ?? "";
    leaveapprovername  = prefs.getString('leaveapprovername') ?? '';

    print("get department == $department");
    setState(() {});
  }

  Future<void> _onRefresh() async {
    await Provider.of<TimesheetProvider>(context, listen: false)
        .fetchTimesheets(refresh: true);
    final provider = Provider.of<TimesheetProvider>(context, listen: false);
    provider.setSearchQuery(_searchController.text);
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
    final authProv = Provider.of<AuthProvider>(context);
    final user = authProv.user;
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
                    'Employee Timesheets',
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
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<TimesheetProvider>(
                builder: (context, provider, _) {
                  //initial loading
                  if (provider.isLoadingTimesheets  && provider.timesheets.isEmpty) {
                    return _buildSkeletonList();
                  }
                  // initial load error
                  if (provider.errorMessage != null && provider.timesheets.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${provider.errorMessage}'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              provider.fetchTimesheets(refresh: true);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (provider.filteredTimesheets.isEmpty) {
                    return const Center(child: Text('No timesheets found.'));
                  }

                  final displayList = _searchController.text.trim().isEmpty
                      ? provider.timesheets
                      : provider.filteredTimesheets;


                  // data loaded + maybe pagination
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: displayList.length + ((provider.hasMore && _searchController.text.trim().isEmpty) ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Pagination loader or error handler at the end of the list
                        if (index == provider.timesheets.length) {
                          if (provider.isLoadingTimesheets && provider.hasMore) {
                            // show bottom loading spinner while fetching next page
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          else {
                            // no more data to load
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "No more list data",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          }
                        }

                        // Normal list item
                        final item = provider.timesheets[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRow('ID', item.name),
                                _buildRow('Name', item.employeeName != "" ? item.employeeName : "-"),
                                _buildRow('From date', DateFormat('dd-MM-yyyy').format(DateTime.parse(item.fromDate))),
                                _buildRow('To date', DateFormat('dd-MM-yyyy').format(DateTime.parse(item.toDate))),
                                _buildRow('Status', item.docStatus == 0 ? "Draft" : "Saved"),
                                _buildRow('Organization', department),
                                _buildRow('Approver', item.approverName != "" ? item.approverName : "-"),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('timesheetApprover', item.approverName);

                                      print("timesheet ==> ${item.approverName}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ApplyTimesheetScreen(
                                            timesheetId: item.name,
                                            empName: item.employeeName,
                                            empId: item.employee,
                                            approverName:item.approverName,
                                            approverID: item.approver,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit, size: 18, color: AppColors.white),
                                    label: const Text(
                                      'Edit',
                                      style: TextStyle(fontSize: 16, color: AppColors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: AppColors.primaryBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
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
              MaterialPageRoute(
                  builder: (_) => ApplyTimesheetScreen(timesheetId: '0',
                      empName: userfullname,
                      empId: empid,
                      )),
            );
          },
          child: Icon(Icons.add),
        ),

      ),
    );
  }

  Widget _buildRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$key:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                _SkeletonRow(),
                SizedBox(height: 8),
                _SkeletonRow(),
                SizedBox(height: 8),
                _SkeletonRow(widthFactor: 0.6),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  final double widthFactor;
  const _SkeletonRow({this.widthFactor = 1.0});

  @override
  Widget build(BuildContext context) {
  return FractionallySizedBox(
    widthFactor: widthFactor,
   child: Container(
      height: 12,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 4),
       ),
     );
  }
}
