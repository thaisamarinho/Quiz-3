require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {create(:user)}

  describe '#create' do

    context 'With user signed out' do
      it 'redirects to the sign in page' do
        comment = build(:comment)
        post :create, {idea_id: comment.idea, comment: attributes_for(:comment)}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}

      it 'redirect to the idea show page' do
        comment = build(:comment)
        post :create, {idea_id: comment.idea, comment: attributes_for(:comment)}
        expect(response).to redirect_to(idea_path(comment.idea))
      end

      it 'associates created comment with logged in user' do
        comment = build(:comment, user_id: user.id)
        post :create, {idea_id: comment.idea, comment: {body: comment.body, idea_id: comment.idea, user_id: comment.user } }
        expect(Comment.last.user_id).to eq(user.id)
      end

    end

    context 'with user signed in and invalid params' do
      before {request.session[:user_id] = user.id}
      def invalid_params
        idea = create(:idea)
        post :create, {idea_id: idea.id, comment: attributes_for(:comment, body: nil)}
      end

      it 'render the idea show page' do
        invalid_params
        expect(response).to render_template('ideas/show')
        expect(flash[:alert]).to be
      end
    end

  end

  describe '#delete' do

    context 'With user signed out' do
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
        comment = create(:comment, idea: idea, user_id: user.id)
        delete :destroy, {id: comment.id}
        expect(response).to redirect_to(idea_path(idea))
      end

      it 'only detele its own comment' do
        comment = create(:comment, user_id: user.id)
        delete :destroy, {id: comment.id}
        expect(response).to redirect_to(idea_path(comment.idea))
      end

      it 'Idea owners can detele any comments on their ideas' do
        idea = create(:idea, user_id: user.id)
        comment = create(:comment, idea_id: idea.id)
        delete :destroy, {id: comment.id}
        expect(response).to redirect_to(idea_path(comment.idea))
      end
    end

  end

end
