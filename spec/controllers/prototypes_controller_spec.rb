require 'rails_helper'

describe PrototypesController do
  let(:user) {create(:user)}

  describe 'GET #index' do

    it "populates an array of prototypes ordered by created_at DESC and assigns @prototypes" do
      prototypes = create_list(:prototype, 3, user_id: user.id)
      get :index
      expect(assigns(:prototypes)).to match(prototypes.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do

    it "assigns @prototype" do
      get :new
      expect(assigns(:prototype)).to be_a_new(Prototype)
    end

    it "renders the :index template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      @params = {prototype: attributes_for(:prototype)}
    end

    it "assigns @prototype" do
      expect{post :create, @params}.to change(Prototype, :count).by(1)
    end

    it "redirect to prototypes_path when prototype is successfully saved" do
      post :create, @params
      expect(response).to redirect_to(root_path)
    end

    it "raises error when params has any missing" do
      expect{post :create, @params[:prototype].store(:title, nil)}.to raise_error
    end
  end

  describe 'GET #show' do
    let(:prototype) {create(:prototype)}
    let(:capturedImage) {create(:capturedImage, status: 0, prototype_id: prototype.id)}
    let(:capturedImage) {create_list(:capturedImage, 3, status: 1, prototype_id: prototype.id)}

    it "assigns @comment" do
      get :show, id: prototype.id
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it "assigns @comments" do
      comments = create_list(:comment, 3, user_id: user.id, prototype_id: prototype.id)
      get :show, id: prototype.id
      expect(assigns(:comments)).to match(comments)
    end

    it "populates array of likes from different users, and assigns @likes" do
      users = create_list(:user, 3)
      likes = []
      users.each do |u|
        like = create(:like, user_id: u.id , prototype_id: prototype.id)
        likes << like
      end
      get :show, id: prototype.id
      expect(assigns(:likes)).to match(likes)
    end

    it "assigns @like when the user has signed in." do
      login user
      users = create_list(:user, 3)
      users << user
      likes = []
      users.each do |u|
        like = create(:like, user_id: u.id , prototype_id: prototype.id)
        likes << like
      end
      like = Like.find_by(user_id:user.id, prototype_id: prototype.id)
      get :show, id: prototype.id
      expect(assigns(:like)).to eq like
    end

    it "does not assigns @like when the user has not signed in." do
      users = create_list(:user, 3)
      users << user
      likes = []
      users.each do |u|
        like = create(:like, user_id: u.id , prototype_id: prototype.id)
        likes << like
      end
      like = Like.find_by(user_id:user.id, prototype_id: prototype.id)
      get :show, id: prototype.id
      expect(assigns(:like)).to eq nil
    end

    it "renders the :show template" do
      get :show, id: prototype.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    let(:prototype) {create(:prototype)}
    let(:capturedImage) {create(:capturedImage, status: 0, prototype_id: prototype.id)}
    let(:capturedImage) {create_list(:capturedImage, 3, status: 1, prototype_id: prototype.id)}

    it "assigns @captured_image" do
      get :edit, id: prototype.id
      expect(assigns(:captured_image)).to be_a_new(CapturedImage)
    end

    it "renders the :edit template" do
      get :edit, id: prototype.id
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:prototype) {create(:prototype)}
    let(:capturedImage) {create(:capturedImage, status: 0, prototype_id: prototype.id)}
    let(:capturedImage) {create_list(:capturedImage, 3, status: 1, prototype_id: prototype.id)}

    it "locates the requersted @prototype" do
      put :update, id: prototype, prototype: attributes_for(:prototype)
      expect(assigns(:prototype)).to eq prototype
    end

    it "changes @prototype's attributes" do
      put :update, id: prototype, prototype: attributes_for(:prototype, title: 'hoge', concept: 'hogehoge')
      prototype.reload
      expect(prototype.title).to eq("hoge")
      expect(prototype.concept).to eq("hogehoge")
    end

    it "redirect to prototype_path(:id) when @prototype is successfully updated" do
      put :update, id: prototype, prototype: attributes_for(:prototype)
      expect(response).to redirect_to prototype_path(prototype)
    end

    it "renders :edit template when @prototype is not updated" do
      expect(put :update, id: prototype, prototype: {title: "", catch_copy: "", concept: "", user_id: ""}).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    let!(:prototype) {create(:prototype)}
    it "deletes @prototype" do
      expect{delete :destroy, id: prototype}.to change(Prototype,:count).by(-1)
    end

    it "redirect to root_path" do
      delete :destroy, id: prototype
      expect(response).to redirect_to root_path
    end
  end
end
