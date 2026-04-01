import 'package:dhira_hrms/providers/attendance_provider.dart';
import 'package:dhira_hrms/providers/bottom_nav_provider.dart';
import 'package:dhira_hrms/providers/login_provider.dart';
import 'package:dhira_hrms/providers/popup_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_provider.dart';
import 'package:dhira_hrms/screens/change_password_screen.dart';
import 'package:dhira_hrms/screens/leave_list_screen.dart';
import 'package:dhira_hrms/screens/timesheet_list_screen.dart';
import 'package:dhira_hrms/services/api_service.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:dhira_hrms/utils/util.dart';
import 'package:dhira_hrms/widgets/action_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import 'ProfileScreen.dart';
import 'login_screen.dart';
import 'organization_chart.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  HomeScreenstate createState() => HomeScreenstate();
  }

class HomeScreenstate extends State<HomeScreen> with SingleTickerProviderStateMixin {
    String userfullname = "";
    String useremail = "";
    String empid = "";
    String department = "";
    late AnimationController _controller;
    late Animation<Offset> _slideAnimation;
    late Animation<double> _fadeAnimation;
    OverlayEntry? _overlayEntry;
    late FocusNode _focusNode;

    final TextEditingController searchController = TextEditingController();

    /// Data for dashboard
    List<DashboardItem> allEmployeeActions = [];
    List<DashboardItem> filteredEmployeeActions = [];

    List<DashboardItem> allCompanyInfo = [];
    List<DashboardItem> filteredCompanyInfo = [];

    @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getdata();
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

    // Listen to search text changes
    searchController.addListener(() {
      _filterSearch(searchController.text);
    });
  }

    @override
    void dispose() {
      _controller.dispose();
      searchController.dispose();
      _focusNode.dispose();
      super.dispose();
    }

  Future<void>  getdata() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userfullname = prefs.getString('userfullname') ?? "";
      useremail = prefs.getString('useremail') ?? "";
      empid = prefs.getString('empid') ?? "";
      department = prefs.getString('department') ?? "";

      // fetch attendance check status
      Provider.of<AttendanceProvider>(context, listen: false)
          .fetchCheckinStatus(empid);

      _populateDashboardItems();
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile(useremail);
      setState(() {});
    }

    void _populateDashboardItems() {
      allEmployeeActions = [
        DashboardItem(
          title: "Timesheet",
          subtitle: "Log your hours",
          assetImagePath: "assets/icons/timesheet_clr.png",
          bgColor: AppColors.iconbgblue,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => TimesheetListScreen()));
          },
        ),
        DashboardItem(
          title: "Leave Application",
          subtitle: "Request time off",
          assetImagePath: "assets/icons/leave_clr.png",
          bgColor: AppColors.iconbggreen,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => LeaveListScreen()));
          },
        ),
        DashboardItem(
          title: "Attendance",
          subtitle: "View records",
          assetImagePath: "assets/icons/attendance_clr.png",
          bgColor: AppColors.iconbgviolet,
          onTap: () {
            Provider.of<BottomNavProvider>(context, listen: false).changeIndex(1);
          },
        ),
        // DashboardItem(
        //   title: "Documents",
        //   subtitle: "Company policies & guidelines",
        //   assetImagePath: "assets/icons/doc_clr.png",
        //   bgColor: AppColors.iconbgblue,
        //   onTap: () {
        //     // Navigate or do something for Documents
        //   },
        // ),
      ];

      allCompanyInfo = [
        // DashboardItem(
        //   title: "Org Calendar",
        //   subtitle: "Holidays & company events",
        //   assetImagePath: "assets/icons/calendar_clr.png",
        //   bgColor: AppColors.iconbgdarkgreen,
        //   onTap: () {
        //
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (_) => CalendarViewWidget(empid: empid,)));
        //
        //     // Navigate or do something for Org Calendar
        //   },
        // ),
        DashboardItem(
          title: "Leaders Board",
          subtitle: "Organization hierarchy",
          assetImagePath: "assets/icons/leader_clr.png",
          bgColor: AppColors.iconbgred,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const OrganizationChart()));
          },
        ),
        // DashboardItem(
        //   title: "Announcements",
        //   subtitle: "Latest company updates",
        //   assetImagePath: "assets/icons/announcements_clr.png",
        //   bgColor: AppColors.iconbgred,
        //   onTap: () {
        //     // Navigate or do something
        //   },
        // ),
      ];

      // Initially, show all
      filteredEmployeeActions = List.from(allEmployeeActions);
      filteredCompanyInfo = List.from(allCompanyInfo);
    }


    void _filterSearch(String query) {
      final lower = query.toLowerCase();

      setState(() {
        if (query.isEmpty) {
          // Show all items when no search query
          filteredEmployeeActions = List.from(allEmployeeActions);
          filteredCompanyInfo = List.from(allCompanyInfo);
        } else {
          // Filter when user has entered something
          filteredEmployeeActions = allEmployeeActions.where((item) =>
          item.title.toLowerCase().contains(lower) ||
              item.subtitle.toLowerCase().contains(lower)
          ).toList();

          filteredCompanyInfo = allCompanyInfo.where((item) =>
          item.title.toLowerCase().contains(lower) ||
              item.subtitle.toLowerCase().contains(lower)
          ).toList();
        }
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
        backgroundColor: AppColors.white,
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
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    // height: 170,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          // Check if state is loaded AND userImage is available
                          backgroundImage: profileProv.state == ProfileState.loaded && profileProv.profile?.userImage != null
                              ? NetworkImage(ApiService.baseUrl + profileProv.profile!.userImage!)
                              : const AssetImage('assets/profile.png') as ImageProvider, // Default image
                          radius: 30,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${Utils.getGreetingMessage()} 👋",
                                    style:
                                    const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w400)),
                                const SizedBox(height: 5),
                                Text(userfullname != "" ? userfullname : user?['displayName'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 5),
                                Text("Senior Software Engineer",
                                    style:
                                    const TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/dashboardimg.png",scale: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: -24, // half of the height of the bar to overlap
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: TextField(
                        controller: searchController,
                        focusNode: _focusNode,  // Use the focusNode here
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          labelText: "search",
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.placeholdergrey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          // Prevent label from floating
                          suffixIcon: searchController.text.isEmpty
                              ? null
                              : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                              }),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: AppColors.bordergrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // Add this
                            borderSide: const BorderSide(
                                width: 3, color: AppColors.primaryBlue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Grid Dashboard
              _buildSection("Employee Actions", filteredEmployeeActions),
              const SizedBox(height: 20),
              _buildSection("Company Information", filteredCompanyInfo),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSection(String title, List<DashboardItem> items) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("No results found.",
                    style: TextStyle(color: Colors.grey.shade600)),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                childAspectRatio: 1,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((item) {
                  return ActionCard(
                    title: item.title,
                    subtitle: item.subtitle,
                    assetImagePath: item.assetImagePath,
                    bgColor: item.bgColor,
                    onTap: item.onTap,
                  );
                }).toList(),
              ),
            ),
        ],
      );
    }
  }

class DashboardItem {
  final String title;
  final String subtitle;
  final String assetImagePath;
  final Color bgColor;
  final VoidCallback onTap;

  DashboardItem({
    required this.title,
    required this.subtitle,
    required this.assetImagePath,
    required this.bgColor,
    required this.onTap,
  });
}