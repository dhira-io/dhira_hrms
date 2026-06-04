import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/org_chart_node_entity.dart';

class OrgChartNodeWidget extends StatelessWidget {
  final OrgChartNodeEntity node;

  const OrgChartNodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          color: Colors.blue.shade50,
          child: Padding(
            padding:       EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 8.0.h,
            ),
            child: Column(
              children: [
                Text(
                  node.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  node.role,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (node.children.isNotEmpty) ...[
          Container(width: 2.w, height: 20.h, color: Colors.grey),
          Wrap(
            spacing: 16,
            children: node.children
                .map((child) => OrgChartNodeWidget(node: child))
                .toList(),
          ),
        ],
      ],
    );
  }
}
