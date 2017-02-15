describe NpcsController do
  let(:user) { FactoryGirl.create :user}
  let(:system) { FactoryGirl.create :system, user_id: user.id}
  let(:npc) { FactoryGirl.create :npc, system_id: system.id }
  let(:new_npc) { FactoryGirl.build :npc }
  let(:strength) { CharacterSkill.create(name: "Strength", level: 3)}
  let(:will) { CharacterSkill.create(name: "Will", level: 3)}
  describe "#create" do
    before(:each) do
      npc.character_skills << strength
      npc.character_skills << will
      post :create, params: {npc: new_npc.attributes}
    end
    it 'saves a new Npc in the database' do
      expect(Npc.last.name).to eq(new_npc.name)
    end
    it 'renders json with npc info to the client' do
      expect(response.body).to include(new_npc.name)
    end

  end
end
