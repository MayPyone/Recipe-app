require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before do
    @user1 = User.create!(id: 5, name: 'Bijay',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png')
    @user2 = User.create!(id: 6, name: 'May',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png')
    @post1 = Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user2)
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/users/#{@user1.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'View for users' do
    it 'show all the included elements from the index page and render the template' do
      get '/users'
      expect(response.body).to include('number of posts:')

      expect(response.body).to render_template('index')
    end

    it 'render the show page' do
      get "/users/#{@user1.id}"
      expect(response.body).to render_template('show')
      expect(response.body).to include("<p class='num-post'>Number of posts: 2</p>")
    end

    it 'mock one element' do
      get '/users'
      assert_includes response.body, @user1.id.to_s
    end
  end
end