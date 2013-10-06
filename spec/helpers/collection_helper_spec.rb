require 'spec_helper'

describe PowerResource::CollectionHelper do
  let(:post) { Post.create(title: 'Test post', content: 'Lorem ipsum dolor') }

  before :each do
    @controller = PostsController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set('@post', post)
  end
  
  describe '#collection_name' do
    it 'returns a name for a current collection' do
      expect(helper.collection_name).to eq('posts')
    end
  end
  
  describe '#collection_human_name' do
    it 'returns humanized name for a current collection' do
      expect(helper.collection_human_name).to eq('Posts')
    end
  end
  
  describe '#collection_title' do
    it 'returns a title for a current collection' do
      expect(helper.collection_title).to eq('Posts')
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
  
    describe '#collection_human_name' do
      it 'returns localized name for a current collection' do
        expect(helper.collection_human_name).to eq('Artikkelit')
      end
    end
    
    describe '#collection_title' do
      it 'returns localized title for a current collection' do
        expect(helper.collection_title).to eq('Lista artikkeleista')
      end
    end
  end
end
