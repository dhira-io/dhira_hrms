import 'package:dhira_hrms/providers/org_chart_provider.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/organization_emp_model.dart';


class OrganizationChart extends StatefulWidget {
  const OrganizationChart({super.key});

  @override
  State<OrganizationChart> createState() => _OrganizationChartState();
}

class _OrganizationChartState extends State<OrganizationChart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrgChartProvider>(context, listen: false).fetchOrganizationData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization Chart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<OrgChartProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text("Error: ${provider.error}"));
          } else if (provider.rootEmployee == null) {
            return const Center(child: Text("No data"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OrgChartCardExpandable(employee: provider.rootEmployee!),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrgChartCardExpandable extends StatefulWidget {
  final Data employee;
  const OrgChartCardExpandable({required this.employee, super.key});

  @override
  State<OrgChartCardExpandable> createState() => _OrgChartCardExpandableState();
}

class _OrgChartCardExpandableState extends State<OrgChartCardExpandable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final emp = widget.employee;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // Index and line
            Column(
              children: [
                Text(emp.indexNumber.toString(), style: const TextStyle(color: Colors.grey)),
                Container(width: 2, height: emp.divisionHead == 1 ? 110 : 80, color: Colors.grey.shade300),
              ],
            ),
            const SizedBox(width: 8),

            //Main card
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: emp.divisionHead == 1
                      ? AppColors.borderOrange
                      : AppColors.bgBlue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: emp.divisionHead == 1
                              ? AppColors.borderOrange
                              : AppColors.bgBlue,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (_) => const EmployeeDetails())
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Department header
                              Container(
                                color: emp.divisionHead == 1 ? AppColors.borderOrglite : AppColors.bglightblue,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(emp.department!.toUpperCase(),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    //   decoration: BoxDecoration(
                                    //     color: emp.divisionHead == 1 ? AppColors.borderOrange : Color(0xFF007AFF),
                                    //     borderRadius: BorderRadius.circular(20),
                                    //   ),
                                    //   child: Text(
                                    //     emp.totalTeam.toString(),
                                    //     style: const TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),

                              //profile info
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: /*emp.profileImage != null
                                          ? NetworkImage(emp.profileImage!)
                                          : const */AssetImage("assets/profile.png")
                                      as ImageProvider,
                                      radius: 24,
                                      child: emp.profileImage == null
                                          ? Text(emp.name?.substring(0, 1) ?? "?")
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (emp.divisionHead == 1)
                                            const Text("DIVISION HEAD",
                                                style: TextStyle(
                                                    color: AppColors.borderOrange,
                                                    fontWeight: FontWeight.w500)),
                                          Text(emp.name ?? "Unknown",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(emp.role ?? "",
                                              style:
                                              const TextStyle(color: Colors.grey)),
                                          // Text(emp.department ?? "",
                                          //     style:
                                          //     const TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    if (emp.directReports != null && emp.directReports! > 0)
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => isExpanded = !isExpanded),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: Colors.black87,
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Row(
                                            children: [
                                              Text(emp.directReports.toString(),
                                                  style:
                                                  const TextStyle(color: Colors.white)),
                                              Icon(
                                                  isExpanded
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons.keyboard_arrow_down,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isExpanded && emp.subEmployees != null)
          ...emp.subEmployees!.map(
                (subEmp) => Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child:
              OrgChartCardExpandable(employee: subEmp),
            ),
          )
      ],
    );
  }
}
