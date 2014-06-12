require 'spec_helper'

describe PowerResource::RenderingHelper do
  let(:post) { Post.create(title: 'Test post', content: 'Lorem ipsum dolor') }

  before :each do
    @controller = PostsController.new
    @controller.request = ActionDispatch::TestRequest.new
    @controller.instance_variable_set('@post', post)
  end

  describe '#render_collection_table' do
    it 'renders collection table' do
      expected = '
        <table class="table">
          <thead>
            <tr>
              <th>Category</th>
              <th>Title</th>
              <th>Content</th>
              <th>&nbsp;</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td></td>
              <td>Test post</td>
              <td>Lorem ipsum dolor</td>
              <td>
                <a class="btn btn-default btn-xs" href="/posts/1/comments">Comments</a>
                <a class="btn btn-default btn-xs" href="/posts/1/edit">Edit</a>
                <a class="btn btn-default btn-xs" data-confirm="Are you sure?" data-method="delete" 
                   href="/posts/1" rel="nofollow">Delete</a>
              </td>
            </tr>
          </tbody>
        </table>
      '
      output = helper.render_collection_table.gsub(/(^ +|\n)/, '')
      expect(output).to eq(expected.gsub(/(^ +|\n)/, ''))
    end
  end
  
  context 'when form builder is form_for' do
    context 'with action :edit' do
      describe '#render_form' do
        it 'renders edit form using form_for' do
          expected = '
            <form accept-charset="UTF-8" action="/posts/1" class="edit_post" 
              id="edit_post_1" method="post">
              <div style="display:none">
                <input name="utf8" type="hidden" value="&#x2713;" />
                <input name="_method" type="hidden" value="patch" />
              </div>
              <ul>
                <li>
                  <label for="post_category_id">Category</label>
                  <select id="post_category_id" name="post[category_id]"></select>
                </li>
                <li>
                  <label for="post_title">Title</label>
                  <input id="post_title" name="post[title]" type="text" 
                         value="Test post" />
                </li>
                <li>
                  <label for="post_content">Content</label>
                  <textarea id="post_content" name="post[content]">
                    Lorem ipsum dolor
                  </textarea>
                </li>
              </ul>
              <input name="commit" type="submit" value="Update Post" />
            </form>
          '
          output = helper.render_form.gsub(/(^ +|\n)/, '')
          expect(output).to eq(expected.gsub(/(^ +|\n)/, ''))
        end
      end
    end

    context 'with action :new' do
      before :each do
        @controller.request.action = 'new'
        @controller.instance_variable_set('@post', Post.new)
      end

      describe '#render_form' do
        it 'renders new form using form_for' do
          expected = '
            <form accept-charset="UTF-8" action="/posts" class="new_post" 
              id="new_post" method="post">
              <div style="display:none">
                <input name="utf8" type="hidden" value="&#x2713;" />
              </div>
              <ul>
                <li>
                  <label for="post_category_id">Category</label>
                  <select id="post_category_id" name="post[category_id]"></select>
                </li>
                <li>
                  <label for="post_title">Title</label>
                  <input id="post_title" name="post[title]" type="text" />
                </li>
                <li>
                  <label for="post_content">Content</label>
                  <textarea id="post_content" name="post[content]"></textarea>
                </li>
              </ul>
              <input name="commit" type="submit" value="Create Post" />
            </form>
          '
          output = helper.render_form.gsub(/(^ +|\n)/, '')
          expect(output).to eq(expected.gsub(/(^ +|\n)/, ''))
        end
      end
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
  
    describe '#render_collection_table' do
      it 'renders localized collection table' do
        expected = '
          <table class="table">
            <thead>
              <tr>
                <th>Kategoria</th>
                <th>Otsikko</th>
                <th>Sisältö</th>
                <th>&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td></td>
                <td>Test post</td>
                <td>Lorem ipsum dolor</td>
                <td>
                  <a class="btn btn-default btn-xs" href="/posts/1/comments">Kommentit</a>
                  <a class="btn btn-default btn-xs" href="/posts/1/edit">Muokkaa</a>
                  <a class="btn btn-default btn-xs" data-confirm="Oletko varma?" data-method="delete" 
                     href="/posts/1" rel="nofollow">Poista</a>
                </td>
              </tr>
            </tbody>
          </table>
        '
        output = helper.render_collection_table.gsub(/(^ +|\n)/, '')
        expect(output).to eq(expected.gsub(/(^ +|\n)/, ''))
      end
    end
  end
end
