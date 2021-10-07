
    it "parses long lock file" do
      res = described_class.parse("spec/fixtures/invalid_yarn.lock")
      expect(res.nil?).to eq(true)
    end
  end
end
