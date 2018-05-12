require 'rails_helper'

describe CommentsController do

  let(:user) {create(:user)}
  let(:prototype) {create(:prototype)}
  let(:capturedImage) {create(:capturedImage, status: 0, prototype_id: prototype.id)}
  let(:capturedImage) {create_list(:capturedImage, 3, status: 1, prototype_id: prototype.id)}

  describe 'POST #create' do

    before do
      @params = {
        prototype_id: prototype, comment:
        attributes_for(:comment,prototype_id: prototype.id, user_id: user.id)}
    end

    context 'user signed in' do

      before do
        login user
      end

      it "save the new @comment" do
        expect{post :create, @params}.to change(Comment, :count).by(1)
      end

      context "can save @comment" do

        it "redirects when data type is html" do
          expect(post :create, @params).to redirect_to(prototype_path(prototype))
        end

        it "has a 200 status code when data type is json" do
          xhr :post, :create, @params
          expect(response).to have_http_status(200)
        end
      end

      it "redirects when could not save @comment" do
        @params[:comment].store(:content, "")
        expect(post :create, @params).to redirect_to(prototype_path(prototype))
      end
    end

    context "user signed out" do

      it "redirect to new_user_session_path when user signed out" do
        post :create, @params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do

    let(:comment){create(:comment, prototype_id: prototype.id, user_id: user.id)}

    before do
      @params = {prototype_id: prototype.id}
      login user
    end

    it "assigns @comment" do
      get :edit, prototype_id: prototype.id, id: comment.id
      expect(assigns(:comment)).to eq comment
    end

    it "assigns @prototype" do
      get :edit, prototype_id: prototype.id, id: comment.id
      expect(assigns(:prototype)).to eq prototype
    end

    it "renders the :edit template" do
      get :edit, prototype_id: prototype.id, id: comment.id
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do

    let(:comment){create(:comment, prototype_id: prototype.id, user_id: user.id)}

    before do
      login user
    end

    it "locates the requested @comment" do
      put :update, prototype_id: prototype.id, id: comment.id, comment: attributes_for(:comment,prototype_id: prototype.id, user_id: user.id)
      expect(assigns(:comment)).to eq comment
    end

    it "changes @comment's attributes" do
      put :update, prototype_id: prototype.id, id: comment, comment: attributes_for(:comment, content: "fuga", prototype_id: prototype.id, user_id: user.id)
      comment.reload
      expect(comment.content).to eq("fuga")
    end

    it "redirect to prototype_path(:id)" do
      put :update, prototype_id: prototype.id, id: comment.id, comment: attributes_for(:comment,prototype_id: prototype.id, user_id: user.id)
      expect(response).to redirect_to prototype_path(prototype)
    end
  end

  describe 'DELETE #destroy' do

    let!(:comment){create(:comment, prototype_id: prototype.id, user_id: user.id)}

    before do
      login user
    end

    it "deletes @comment" do
      expect{delete :destroy, prototype_id: prototype.id, id: comment}.to change(Comment,:count).by(-1)
    end

    it "redirect to prototype_path(:id)" do
      delete :destroy, prototype_id: prototype.id, id: comment
      expect(response).to redirect_to prototype_path(prototype)
    end
  end
end
