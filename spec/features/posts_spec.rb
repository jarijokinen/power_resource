require 'spec_helper'

feature 'Posts' do
  scenario 'User visits posts index page' do
    visit '/posts'
    expect(page).to have_css('h1', text: 'Posts')
  end
end
