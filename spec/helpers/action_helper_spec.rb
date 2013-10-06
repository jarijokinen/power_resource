require 'spec_helper'

describe PowerResource::ActionHelper do
  let(:post) { Post.create(title: 'Test post', content: 'Lorem ipsum dolor') }

  before :each do
    @controller = PostsController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set('@post', post)
  end

  describe '#resource_action_human_name' do
    it 'returns humanized collection name for an index action' do
      expect(helper.resource_action_human_name(:index)).to eq('Posts')
    end
    
    it 'returns humanized name for a new action' do
      expect(helper.resource_action_human_name(:new)).to eq('New Post')
    end
    
    it 'returns humanized name for an edit action' do
      expect(helper.resource_action_human_name(:edit)).to eq('Edit Post')
    end
    
    it 'returns humanized name for a delete action' do
      expect(helper.resource_action_human_name(:delete)).to eq('Delete Post')
    end
    
    it 'returns humanized name for a custom action' do
      expect(helper.resource_action_human_name(:duplicate)).to eq('Duplicate Post')
    end
  end
  
  describe '#resource_action_title' do
    it 'returns humanized collection name for an index action' do
      expect(helper.resource_action_title(:index)).to eq('Posts')
    end
    
    it 'returns a title for a new action' do
      expect(helper.resource_action_title(:new)).to eq('New Post')
    end
    
    it 'returns a title for an edit action' do
      expect(helper.resource_action_title(:edit)).to eq('Edit Post')
    end
    
    it 'returns a title for a delete action' do
      expect(helper.resource_action_title(:delete)).to eq('Delete Post')
    end
    
    it 'returns a title for a custom action' do
      expect(helper.resource_action_title(:duplicate)).to eq('Duplicate Post')
    end
  end
  
  ### Localization specs
  
  context 'when locale is set' do
    before :each do
      I18n.locale = :fi
    end

    after :each do
      I18n.locale = I18n.default_locale
    end

    describe '#resource_action_human_name' do
      it 'returns localized collection name for an index action' do
        expect(helper.resource_action_human_name(:index)).to eq('Artikkelit')
      end
      
      it 'returns localized name for a new action' do
        expect(helper.resource_action_human_name(:new)).to eq('Uusi artikkeli')
      end
      
      it 'returns localized name for an edit action' do
        expect(helper.resource_action_human_name(:edit)).to eq('Muokkaa Artikkeli')
      end
      
      it 'returns localized name for a delete action' do
        expect(helper.resource_action_human_name(:delete)).to eq('Poista Artikkeli')
      end
      
      it 'returns localized name for a custom action' do
        expect(helper.resource_action_human_name(:duplicate)).to eq('Kopioi Artikkeli')
      end
    end
    
    describe '#resource_action_title' do
      it 'returns localized collection name for an index action' do
        expect(helper.resource_action_title(:index)).to eq('Artikkelit')
      end
      
      it 'returns localized title for a new action' do
        expect(helper.resource_action_title(:new)).to eq('Uusi artikkeli')
      end
      
      it 'returns localized title for an edit action' do
        expect(helper.resource_action_title(:edit)).to eq('Muokkaa artikkelia')
      end
      
      it 'returns localized title for a delete action' do
        expect(helper.resource_action_title(:delete)).to eq('Poista Artikkeli')
      end
      
      it 'returns localized title for a custom action' do
        expect(helper.resource_action_title(:duplicate)).to eq('Kopioi Artikkeli')
      end
    end
  end
end
