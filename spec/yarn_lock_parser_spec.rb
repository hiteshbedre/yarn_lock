   hospital_name = serializers.CharField(source="consultation.facility.name")
    hospital_pincode = serializers.CharField(source="consultation.facility.pincode")

    medical_conditions_list = serializers.ListSerializer(child=ChoiceField(choices=DISEASE_CHOICES))

    class Meta:
        model = PatientSampleICMR


    @Override
    public void runOnClick(JComponent comp) {
        if ("btnCreatePayroll".equals(comp.getName())) {
            createPayroll();
        }
        else if ("btnPostGL".equals(comp.getName())) {
            postGL();
        }
        else if ("btnViewGL".equals(comp.getName())) {
            viewGL();
        }
        else if ("btnGeneratePayroll".equals(comp.getName())) {
            generatePayroll();
        }
    }

    protected void createPayroll() {
//        PayrollAction.showPayrollWizard();
        PayrollPeriod p = (PayrollPeriod) this.getBean();
        List<Payroll> lstPay = p.getListPayroll();
        p.absent = getTotal(lstPay, "absent");
        p.allowance = getTotal(lstPay, "allowance");
        p.basicPay = getTotal(lstPay, "basicPay");
        p.colaAllowance = getTotal(lstPay, "colaAllowance");
        p.deduction = getTotal(lstPay, "deduction");
        p.grossPay = getTotal(lstPay, "grossPay");
        p.holidayPay = getTotal(lstPay, "holidayPay");
        p.late = getTotal(lstPay, "late");
        p.loan = getTotal(lstPay, "loan");
        p.mealAllowance = getTotal(lstPay, "mealAllowance");
        p.netPay = getTotal(lstPay, "netPay");
        p.nightDiff = getTotal(lstPay, "nightDiff");
        p.otPay = getTotal(lstPay, "otPay");
        p.otherAllowance = getTotal(lstPay, "otherAllowance");
        p.pagibig = getTotal(lstPay, "pagibig");
        p.philhealth = getTotal(lstPay, "philhealth");
        p.sss = getTotal(lstPay, "sss");
        p.tardiness = getTotal(lstPay, "tardiness");
        p.tax = getTotal(lstPay, "tax");
        p.taxExemption = getTotal(lstPay, "taxExemption");
        p.taxReturn = getTotal(lstPay, "taxReturn");
        p.taxableIncome = getTotal(lstPay, "taxableIncome");
        p.transpoAllowanc
