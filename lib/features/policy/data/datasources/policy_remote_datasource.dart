import 'package:logger/logger.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/policy_api_constants.dart';
import '../models/policy_model.dart';
import '../models/policy_pdf_model.dart';

abstract class IPolicyRemoteDataSource {
  Future<List<PolicyModel>> getPolicies();
  Future<PolicyPdfModel> getPolicyPdf(String fileUrl);
}

class PolicyRemoteDataSourceImpl implements IPolicyRemoteDataSource {
  final DioClient dioClient;
  final Logger logger;

  PolicyRemoteDataSourceImpl({required this.dioClient, required this.logger});

  @override
  Future<List<PolicyModel>> getPolicies() async {
    final response = await dioClient.get(PolicyApiConstants.getPolicies);
    final policyResponse = PolicyResponseModel.fromJson(response.data);
    return policyResponse.message.policies;
  }

  @override
  Future<PolicyPdfModel> getPolicyPdf(String fileUrl) async {
    final response = await dioClient.get(
      PolicyApiConstants.getPdfFileBase64,
      queryParameters: {'file_url': fileUrl},
    );
    final pdfResponse = PolicyPdfResponseModel.fromJson(response.data);
    return pdfResponse.message;
  }
}
