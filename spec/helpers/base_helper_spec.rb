require 'spec_helper'

describe PowerResource::BaseHelper do
  let(:post) { Post.create(title: 'Test post', content: 'Lorem ipsum dolor') }

  before :each do
    @controller = PostsController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set('@post', post)
  end

  describe '#resource_name' do
    it 'returns a name for a current resource' do
      expect(helper.resource_name).to eq('post')
    end
  end
  
  describe '#resource_human_name' do
    it 'returns humanized name for a current resource' do
      expect(helper.resource_human_name).to eq('Post')
    end
  end
  
  describe '#resource_human_name_for' do
    it 'returns humanized name for a specific resource' do
      expect(helper.resource_human_name_for('Post')).to eq('Post')
    end
  end
  
  describe '#resource_title' do
    it 'returns an unique title for a current resource' do
      expected_title = "Post #{post.id}"
      expect(helper.resource_title).to eq(expected_title)
    end
  end
  
  describe '#resource_attributes' do
    it 'returns all attributes for a resource' do
      expected_attributes = %w(id category_id title content created_at updated_at)
      expect(helper.resource_attributes).to be == expected_attributes
    end
  end
  
  describe '#resource_non_human_attributes' do
    it 'returns attributes that should be invisible for end-users' do
      expected_attributes = %w(id created_at updated_at)
      expect(helper.resource_non_human_attributes).to be == expected_attributes
    end
  end
  
  describe '#resource_human_attributes' do
    it 'returns attributes for a resource without non-human attributes' do
      expected_attributes = %w(category_id title content)
      expect(helper.resource_human_attributes).to be == expected_attributes
    end
  end
  
  describe '#resource_attribute_human_name_for' do
    it 'returns humanized attribute name' do
      expect(helper.resource_attribute_human_name_for(:title)).to eq('Title')
    end
  end
  
  describe '#attribute_value_for' do
    it 'returns preformatted attribute value of a specific resource' do
      expect(helper.attribute_value_for(post, :title)).to eq('Test post')
    end
  end
  
  describe '#resource_form_path' do
    it 'returns a resource path for an existing resource' do
      expect(helper.resource_form_path).to eq("/posts/#{post.id}")
    end
    
    it 'returns a collection path for a new resource' do
      @controller.request.action = 'new'
      @controller.instance_variable_set('@post', Post.new)
      expect(helper.resource_form_path).to eq('/posts')
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

    describe '#resource_human_name' do
      it 'returns localized name for a current resource' do
        expect(helper.resource_human_name).to eq('Artikkeli')
      end
    end
  
    describe '#resource_human_name_for' do
      it 'returns localized name for a specific resource' do
        expect(helper.resource_human_name_for('Post')).to eq('Artikkeli')
      end
    end
  
    describe '#resource_title' do
      it 'returns an unique localized title for a current resource' do
        expected_title = "Artikkeli nro #{post.id}"
        expect(helper.resource_title(resource_id: post.id)).to eq(expected_title)
      end
    end
  
    describe '#resource_attribute_human_name_for' do
      it 'returns localized attribute name' do
        expect(helper.resource_attribute_human_name_for(:title)).to eq('Otsikko')
      end
    end
  end
end
