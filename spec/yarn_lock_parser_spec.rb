from rest_framework import serializers
# Copyright (c) 2015, Frappe Technologies Pvt. Ltd. and Contributors
# License: GNU General Public License v3. See license.txt

from __future__ import unicode_literals

import frappe
from frappe import _
from frappe.desk.doctype.global_search_settings.global_search_settings import update_global_search_doctypes
from frappe.utils.dashboard import sync_dashboards

def install():
	update_genders()
	update_salutations()
	update_global_search_doctypes()
	setup_email_linking()
	sync_dashboards()
	add_unsubscribe()

@frappe.whitelist()
def update_genders():
	default_genders = ["Male", "Female", "Other","Transgender", "Genderqueer", "Non-Conforming","Prefer not to say"]
	records = [{'doctype': 'Gender', 'gender': d} for d in default_genders]
	for record in records:
		frappe.get_doc(record).insert(ignore_permissions=True, ignore_if_duplicate=True)

@frappe.whitelist()
def update_salutations():
	default_salutations = ["Mr", "Ms", 'Mx', "Dr", "Mrs", "Madam", "Miss", "Master", "Prof"]
	records = [{'doctype': 'Salutation', 'salutation': d} for d in default_salutations]
	for record in records:
		doc = frappe.new_doc(record.get("doctype"))
		doc.update(record)
		doc.insert(ignore_permissions=True, ignore_if_duplicate=True)

def setup_email_linking():
	doc = frappe.get_doc({
		"doctype": "Email Account",
		"email_id": "email_linking@example.com",
	})
	doc.insert(ignore_permissions=True, ignore_if_duplicate=True)

def add_unsubscribe():
	email_unsubscribe = [
		{"email": "admin@example.com", "global_unsubscribe": 1},
		{"email": "guest@example.com", "global_unsubscribe": 1}
	]

	for unsubscribe in email_unsubscribe:
		if not frappe.get_all("Email Unsubscribe", filters=unsubscribe):
			doc = frappe.new_doc("Email Unsubscribe")
			doc.update(unsubscribe)
			doc.insert(ignore_permissions=True)

from care.facility.models import DISEASE_CHOICES, SAMPLE_TYPE_CHOICES, SYMPTOM_CHOICES
from care.facility.models.patient_icmr import PatientConsultationICMR, PatientIcmr, PatientSampleICMR
from care.users.models import GENDER_CHOICES
@frappe.whitelist()
def update_genders():
	default_genders = ["Male", "Female", "Other","Transgender", "Genderqueer", "Non-Conforming","Prefer not to say"]
	records = [{'doctype': 'Gender', 'gender': d} for d in default_genders]
	for record in records:
		frappe.get_doc(record).insert(ignore_permissions=True, ignore_if_duplicate=True)

from config.serializers import ChoiceField

public const int BDK_E_BANNEDPERSON = unchecked((int)0x8004b549); // -2147175095
		public const int BDK_E_CANNOT_EXCEED_MAX_OWNERSHIP = unchecked((int)0x8004b54a); // -2147175094
		public const int BDK_E_COUNTRY_CURRENCY_PI_MISMATCH = unchecked((int)0x8004b54b); // -2147175093
		public const int BDK_E_CREDIT_CARD_EXPIRED = unchecked((int)0x8004b54c); // -2147175092
		public const int BDK_E_DATE_EXPIRED = unchecked((int)0x8004b54d); // -2147175091
		public const int BDK_E_ERROR_COUNTRYCODE_MISMATCH = unchecked((int)0x8004b54e); // -2147175090
		public const int BDK_E_ERROR_COUNTRYCODE_REQUIRED = unchecked((int)0x8004b54f); // -2147175089

class ICMRPersonalDetails(serializers.ModelSerializer):
    age_years = serializers.IntegerField()
    age_months = serializers.IntegerField()
    gender = ChoiceField(choices=GENDER_CHOICES)
    email = serializers.EmailField(allow_blank=True)
    pincode = serializers.CharField()

    local_body_name = serializers.CharField()
    district_name = serializers.CharField()
    state_name = serializers.CharField()

    class Meta:
        model = PatientIcmr
        fields = (
            "name",
            "gender",
            "age_years",
            "age_months",
            "date_of_birth",
            "phone_number",
            "email",
            "address",
            "pincode",
            "passport_no",
            # "aadhar_no",
            "local_body_name",
            "district_name",
            "state_name",
        )


class ICMRSpecimenInformationSerializer(serializers.ModelSerializer):
    sample_type = ChoiceField(choices=SAMPLE_TYPE_CHOICES)
    created_date = serializers.DateTimeField()
    label = serializers.CharField()
    is_repeated_sample = serializers.BooleanField(allow_null=True)
    lab_name = serializers.CharField()
    lab_pincode = serializers.CharField()

    icmr_category = ChoiceField(choices=PatientSampleICMR.PATIENT_ICMR_CATEGORY, required=False)

    class Meta:
        model = PatientSampleICMR
        fields = (
            "sample_type",
            "created_date",
            "label",
            "is_repeated_sample",
            "lab_name",
            "lab_pincode",
            "icmr_category",
            "icmr_label",
        )


class ICMRPatientCategorySerializer(serializers.ModelSerializer):
    symptomatic_international_traveller = serializers.BooleanField(allow_null=True)
    symptomatic_contact_of_confirmed_case = serializers.BooleanField(allow_null=True)
    symptomatic_healthcare_worker = serializers.BooleanField(allow_null=True)
    hospitalized_sari_patient = serializers.BooleanField(allow_null=True)
    asymptomatic_family_member_of_confirmed_case = serializers.BooleanField(allow_null=True)
    asymptomatic_healthcare_worker_without_protection = serializers.BooleanField(allow_null=True)

    class Meta:
        model = PatientConsultationICMR
        fields = (
            "symptomatic_international_traveller",
            "symptomatic_contact_of_confirmed_case",
            "symptomatic_healthcare_worker",
            "hospitalized_sari_patient",
            "asymptomatic_family_member_of_confirmed_case",
            "asymptomatic_healthcare_worker_without_protection",
        )


class ICMRExposureHistorySerializer(serializers.ModelSerializer):
    has_travel_to_foreign_last_14_days = serializers.BooleanField()
    places_of_travel = serializers.CharField(source="countries_travelled")
    travel_start_date = serializers.DateField()
    travel_end_date = serializers.DateField()

    contact_with_confirmed_case = serializers.BooleanField(source="contact_with_confirmed_carrier")
    contact_case_name = serializers.CharField()

    was_quarantined = serializers.BooleanField(allow_null=True)
    quarantined_type = serializers.CharField()

    healthcare_worker = serializers.BooleanField(source="is_medical_worker")

    class Meta:
        model = PatientIcmr
        fields = (
            "has_travel_to_foreign_last_14_days",
            "places_of_travel",
            "travel_start_date",
            "travel_end_date",
            "contact_with_confirmed_case",
            "contact_case_name",
            "was_quarantined",
            "quarantined_type",
            "healthcare_worker",
        )


class ICMRMedicalConditionSerializer(serializers.ModelSerializer):
    date_of_onset_of_symptoms = serializers.DateField()
    symptoms = serializers.ListSerializer(child=ChoiceField(choices=SYMPTOM_CHOICES))
    hospitalization_date = serializers.DateField()
    hospital_phone_number = serializers.CharField(source="consultation.facility.phone_number")
    hospital_name = serializers.CharField(source="consultation.facility.name")
    hospital_pincode = serializers.CharField(source="consultation.facility.pincode")

    medical_conditions_list = serializers.ListSerializer(child=ChoiceField(choices=DISEASE_CHOICES))

    class Meta:
        model = PatientSampleICMR
        fields = (
            # Section B.3
            "date_of_onset_of_symptoms",
            "symptoms",
            "has_sari",
            "has_ari",
            # Section B.4
            "medical_conditions_list",
            # Section B.5
            "hospitalization_date",
            "diagnosis",
            "diff_diagnosis",
            "etiology_identified",
            "is_atypical_presentation",
            "is_unusual_course",
            "hospital_phone_number",
            "hospital_name",
            "hospital_pincode",
            "doctor_name",
        )


class PatientICMRSerializer(serializers.ModelSerializer):
    id = serializers.CharField(source="external_id", read_only=True)
    personal_details = ICMRPersonalDetails()
    specimen_details = ICMRSpecimenInformationSerializer()
    patient_category = ICMRPatientCategorySerializer()
    exposure_history = ICMRExposureHistorySerializer()
    medical_conditions = ICMRMedicalConditionSerializer()

    class Meta:
        model = PatientSampleICMR
        fields = (
            "id",
            "personal_details",
            "specimen_details",
            "patient_category",
            "exposure_history",
            "medical_conditions",
        )



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
