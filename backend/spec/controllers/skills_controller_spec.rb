describe SkillsController do
  let(:user) { FactoryGirl.create :user}
  let(:system) { FactoryGirl.create :system, user_id: user.id}
  let(:skill) { FactoryGirl.create :skill }
  describe '#index' do
    before(:each) do
      get :index, params: {system_id: system.id}
    end
    it "renders a json blob containing all skills associated with a system" do
      expect(response.body).to eq(Skill.all.to_json)
    end
    it "responds with a 200" do
      expect(response.status).to eq(200)
    end
  end
end
