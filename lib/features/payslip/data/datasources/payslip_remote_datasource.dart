import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/payslip_detail_model.dart';
import '../models/payslip_model.dart';
import '../constants/payslip_constants.dart';

abstract class PayslipRemoteDataSource {
  Future<List<PayslipModel>> fetchPayslips({
    required String employeeId,
    required int start,
    required int limit,
  });

  Future<PayslipDetailModel> fetchPayslipDetail({required String name});
}

class PayslipRemoteDataSourceImpl implements PayslipRemoteDataSource {
  final DioClient dioClient;

  PayslipRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<PayslipModel>> fetchPayslips({
    required String employeeId,
    required int start,
    required int limit,
  }) async {
    try {
      final response = await dioClient.get(
        PayslipApiConstants.salarySlipResource,
        queryParameters: {
          'fields': jsonEncode([
            'name',
            'employee',
            'employee_name',
            'company',
            'posting_date',
            'status',
            'net_pay',
            'gross_pay',
            'total_deduction',
            'start_date',
            'end_date',
            'total_working_days',
          ]),
          'filters': jsonEncode([
            ['employee', '=', employeeId],
          ]),
          'order_by': 'modified desc',
          'limit_start': start,
          'limit_page_length': limit,
        },
      );

      final List data = response.data['data'] ?? [];
      return data.map((e) => PayslipModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<PayslipDetailModel> fetchPayslipDetail({required String name}) async {
    try {
      final response = await dioClient.get(
        PayslipApiConstants.getDocMethod,
        queryParameters: {'doctype': 'Salary Slip', 'name': name},
      );

      final doc = response.data['docs'] != null
          ? (response.data['docs'] as List).first
          : response.data['message'];

      if (doc == null) {
        throw ServerException(message: 'Payslip not found');
      }

      return PayslipDetailModel.fromJson(doc);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
