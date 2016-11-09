require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {create(:user)}

  describe '#create' do

    context 'With no user signed in' do
      it 'redirects to the sign in page' do
        idea = create(:idea)
        post :create, {idea_id: idea.id, comment: attributes_for(:comment, user_id: nil)}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}

      it 'redirect to the idea show page' do
        idea = create(:idea)
        post :create, {idea_id: idea.id, comment: attributes_for(:comment)}
        expect(response).to redirect_to(idea_path(idea))
      end

    end

    context 'with valid params' do
      before {request.session[:user_id] = user.id}
      def valid_params
        idea = create(:idea)
        post :create, {idea_id: idea.id, comment: attributes_for(:comment)}
      end
      it 'redirects to the idea show page' do
        valid_params
        expect(response).to redirect_to(idea_path(Idea.last))
      end
    end

    context 'with invalid params' do
      before {request.session[:user_id] = user.id}
      def invalid_params
        idea = create(:idea)
        post :create, {idea_id: idea.id, comment: attributes_for(:comment, body: nil)}
      end
      it 'render the idea show page' do
        invalid_params
        expect(response).to render(:show)
      end
    end

  end

  describe '#delete' do

    context 'With no user signed in' do
      it 'redirects to the sign in page' do
        comment = create(:comment)
        delete :destroy, {id: comment.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}

      it 'redirect to the idea show page' do
        idea = create(:idea)
        comment = create(:comment, idea: idea, user_id: session[:user_id])
        delete :destroy, {id: comment.id}
        expect(response).to redirect_to(idea_path(idea))
      end

      it 'only detele its own comment' do
        user = create(:user)
        comment = create(:comment, user: user)
        delete :destroy, {id: comment.id}
        expect(response).to redirect_to(root_path)
      end
    end

  end

end
