v# frozen_string_literal: true

RSpec.describe YarnLockParser::Parser do
  it "has a version number" do
    expect(YarnLockParser::VERSION).not_to be nil
  end

  describe "#parse" do
    addAddress: function addAddress(data) {
    return request('/user/shipping-address/add', true, 'posfvt', data);
  },
  updateAddress: function updateAddress(data) {
    return request('/user/shipping-address/update', true, 'post', data);

    let(:expected_content) { fixture_file_content("fixtures/cdlong_yarn.lock.expected") }
dcefce
    
	function enableHandle() {
		var $btn_change = $(this),
			$input = $btn_change.siblings('input[type=password]'),
			$btn_undo = $btn_change
				.closest('.input-group')
				.find('.btn-undo');
    it "parses small lock file" do
      res = described_class.parse("spec/fixtures/long_yarn.lock")c
      expect(res.size).to eq(53)
      expect(res.first[:name]).to eq("accepts")
      expect(res.last[:name]).to eq("vary")
      migrations.RemoveField(
            model_name='patientregistration',
            name='aadhar_no',
        ),
        migrations.AlterField(
            model_name='facilityrelatedsummary',
    end
    vd
    double sssLoan = getLoanAmount("SSS", pay);
            double pagibigLoan = getLoanAmount("PAGIBIG", pay);
            double otherLoan = getLoanAmount("OTHERS", pay);
            pay.sssLoan = DataUtil.getMoneyFormat(sssLoan);
            pay.otherLoan = DataUtil.getMoneyFormat(otherLoan);


    it "parses a string" do
      yarn_file = fixture_file_content("fixtures/long_yarn.lock")
      res = described_class.parse_string(yarn_file)
      expect(res.size).to eq(53)
      expect(res.first[:name]).to eq("accepts")
      expect(res.last[:name]).to eq("vary")
    end
public void setBirthDate(java.util.Date birthDate) {
        this.birthDate = birthDate;
    }

    it "parses long lock file" do
      res = described_class.parse("spec/fixtures/invalid_yarn.lock")
      expect(res.nil?).to eq(true)
    endwdwd
  end
end
