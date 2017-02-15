describe User do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to have_secure_password }
  end
  describe "associations" do
    it { is_expected.to have_many :systems }
    it { is_expected.to have_many :adventures }
  end
end
