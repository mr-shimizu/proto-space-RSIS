require 'rails_helper'

describe PrototypesController do

  shared_examples_for "render template" do |template|
    it { subject; expect(response).to render_template template}
  end

  shared_examples_for "assings new instance of the model" do |instance, model|
    it do
      subject
      expect(assigns(instance)).to be_a_new(model)
    end
  end

  let(:user) {create(:user)}

  describe 'GET #index' do

    let(:prototypes) { create_list(:prototype, 3, user_id: user.id).sort{ |a, b| b.created_at <=> a.created_at } }

    subject { get :index }

    it "populates an array of prototypes ordered by created_at DESC" do
      subject
      expect(assigns(:prototypes)).to match(
        prototypes.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it_behaves_like "render template", :index
  end


  describe 'GET #new' do

    subject { get :new }

    it_behaves_like "assings new instance of the model", :prototype, Prototype

    it_behaves_like "render template", :new
  end

  describe 'POST #create' do
    before do
      @params = {prototype: attributes_for(:prototype)}
    end

    subject {post :create, @params}

    it { expect{subject}.to change(Prototype, :count).by(1) }

    context "with valid params" do

      it { subject; expect(response).to redirect_to root_path }
    end

    context "with invalid params" do
      it { expect{post :create, @params[:prototype].store(:title, nil)}.to raise_error }
    end
  end

  describe 'GET #show' do
    let(:prototype) {create(:prototype)}

    before do
      @likes = []
      users = create_list(:user, 3)
      users << user
      users.each do |u|
        like = create(:like, user_id: u.id , prototype_id: prototype.id)
        @likes << like
      end
    end

    let(:comments) { create_list(:comment, 3, user_id: user.id, prototype_id: prototype.id) }

    subject {get :show, id: prototype.id}

    it_behaves_like "assings new instance of the model", :comment, Comment

    it "assigns @comments" do
      subject
      expect(assigns(:comments)).to match(comments)
    end

    it "populates array of likes from all users" do
      subject
      expect(assigns(:likes)).to match(@likes)
    end

    context "when the user has signed in" do
      before do
        login user
      end

      it "assigns @like" do
        like = Like.find_by(user_id:user.id, prototype_id: prototype.id)
        subject
        expect(assigns(:like)).to eq like
      end

    end

    it "does not assigns @like when the user has not signed in." do
      like = Like.find_by(user_id:user.id, prototype_id: prototype.id)
      subject
      expect(assigns(:like)).to eq nil
    end

    it_behaves_like "render template", :show
  end

  describe 'GET #edit' do
    let(:prototype) {create(:prototype)}

    subject {get :edit, id: prototype.id}

    it_behaves_like "assings new instance of the model", :captured_image, CapturedImage

    it_behaves_like "render template", :edit
  end

  describe 'PUT #update' do
    let(:prototype) {create(:prototype)}


    it "locates the requersted @prototype" do
      put :update, id: prototype, prototype: attributes_for(:prototype)
      expect(assigns(:prototype)).to eq prototype
    end

    it "changes @prototype's attributes" do
      put :update, id: prototype, prototype:
        attributes_for(:prototype, title: 'hoge', concept: 'hogehoge')
      prototype.reload
      expect(prototype.title).to eq("hoge")
      expect(prototype.concept).to eq("hogehoge")
    end

    context "when @prototype is successfully updated" do

      it "redirect to prototype_path" do
        put :update, id: prototype, prototype: attributes_for(:prototype)
        expect(response).to redirect_to prototype_path(prototype)
      end

    end

    context "when @prototype is not updated" do

      subject{put :update, id: prototype, prototype: {title: "", catch_copy: "", concept: "", user_id: ""}}

      it_behaves_like "render template", :edit
    end
  end

  describe 'DELETE #destroy' do

    let!(:prototype) {create(:prototype)}

    subject {delete :destroy, id: prototype}
    it "deletes @prototype" do
      expect{subject}.to change(Prototype,:count).by(-1)
    end

    it { subject; expect(response).to redirect_to root_path }
  end
end
