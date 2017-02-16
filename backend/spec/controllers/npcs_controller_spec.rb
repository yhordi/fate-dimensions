describe NpcsController do
  let(:user) { FactoryGirl.create :user}
  let(:system) { FactoryGirl.create :system, user_id: user.id}
  let!(:npc) { FactoryGirl.create :npc, system_id: system.id }
  let(:new_npc) { FactoryGirl.build :npc }
  let(:strength) { CharacterSkill.create(name: "Strength", level: 3)}
  let(:will) { CharacterSkill.create(name: "Will", level: 3)}
  describe "#create" do
    context 'on valid params' do
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
    context 'on invalid params' do
      it 'responds with errors as json' do
        post :create, params: {npc: npc.attributes}
        expect(response.body).to include("Name has already been taken".to_json)
      end
      it 'does not save a new npc in the database' do
        no_name = ''
        post :create, params: {npc: {name: no_name}}
        expect(Npc.last).to_not eq(no_name)
      end
    end
  end
  describe '#index' do
    before(:each) do
      get :index, params: {system_id: system.id}
    end
    it 'renders JSON containing all npcs associated with a system' do
      expect(response.body).to include(Npc.all.to_json)
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end
    context 'includes' do
      it 'character_skills' do
        expect(response.body).to include(npc.character_skills.to_json)
      end
      it 'stunts' do
        expect(response.body).to include(npc.stunts.to_json)
      end
      it 'aspects' do
        expect(response.body).to include(npc.aspects.to_json)
      end
      it 'consequences' do
        expect(response.body).to include(npc.consequences.to_json)
      end
    end
  end
  describe '#update' do
    before(:each) do
      patch :update, params: {npc: {name: npc.name, background: 'laksdjflaskdjflak013948 i1h', system_id: system.id}, id: npc.id}
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end
    it 'updates an npc in the database' do
      expect(npc.reload.background).to eq('laksdjflaskdjflak013948 i1h')
    end
    it 'renders JSON containing the updated npc' do
      expect(response.body).to include('laksdjflaskdjflak013948 i1h'.to_json)
    end
  end
  describe '#destroy' do
    it 'deletes an npc in the database' do
      expect{delete :destroy, params: {id: npc.id}}.to change{Npc.all.count}.by(-1)
    end
    it 'responds with json of all systems' do
      delete :destroy, params: {id: npc.id}
      expect(response.body).to eq(Npc.all.to_json)
    end
  end
end
