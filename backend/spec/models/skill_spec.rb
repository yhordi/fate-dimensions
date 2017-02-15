describe Skill do
  let(:user) { FactoryGirl.create :user }
  let(:system) { FactoryGirl.create :system, user_id: user.id }
  let!(:skill) { FactoryGirl.create :skill, system_id: system.id }
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:system_id) }
  end
  describe '#names' do
    it 'returns an array containing skill names' do
      expect(Skill.names(system.id)).to include(skill.name)
    end
  end
end
