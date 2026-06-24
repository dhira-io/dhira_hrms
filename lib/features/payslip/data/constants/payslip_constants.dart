class PayslipApiConstants {
  PayslipApiConstants._();

  static const String salarySlipResource = '/api/resource/Salary Slip';
  static const String getDocMethod = '/api/method/frappe.client.get';
  static const String downloadSalarySlips =
      '/api/method/dhira_hrms.api.payroll.download_salary_slips_pdf';
}

class PayslipStatusConstants {
  PayslipStatusConstants._();

  static const String submitted = 'submitted';
  static const String draft = 'draft';
  static const String paid = 'paid';
}
