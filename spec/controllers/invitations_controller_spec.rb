require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:company) { create(:company) }
  let(:valid_attributes) { attributes_for(:invitation, company_id: company.id) }
  let(:invalid_attributes) { attributes_for(:invitation, email: 'invalid_email') }

  before { sign_in admin }

  describe 'GET #index' do
    it 'returns a success response' do
      create(:invitation, admin: admin)
      get :index
      expect(response).to be_successful
    end

    it 'lists only invitations from current admin' do
      invitation = create(:invitation, admin: admin)
      other_invitation = create(:invitation, admin: create(:admin))

      get :index
      expect(assigns(:invitations)).to include(invitation)
      expect(assigns(:invitations)).not_to include(other_invitation)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      invitation = create(:invitation, admin: admin)
      get :show, params: { id: invitation.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      invitation = create(:invitation, admin: admin)
      get :edit, params: { id: invitation.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Invitation' do
        expect {
          post :create, params: { invitation: valid_attributes }
        }.to change(Invitation, :count).by(1)
      end

      it 'associates the invitation with current admin' do
        post :create, params: { invitation: valid_attributes }
        expect(Invitation.last.admin).to eq(admin)
      end

      it 'redirects to the invitations list' do
        post :create, params: { invitation: valid_attributes }
        expect(response).to redirect_to(invitations_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (renders the new template)' do
        post :create, params: { invitation: invalid_attributes }
        expect(response).to be_successful
      end

      it 'does not create a new invitation' do
        expect {
          post :create, params: { invitation: invalid_attributes }
        }.not_to change(Invitation, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New Name' } }

      it 'updates the requested invitation' do
        invitation = create(:invitation, admin: admin)
        put :update, params: { id: invitation.id, invitation: new_attributes }
        invitation.reload
        expect(invitation.name).to eq('New Name')
      end

      it 'redirects to the invitations list' do
        invitation = create(:invitation, admin: admin)
        put :update, params: { id: invitation.id, invitation: new_attributes }
        expect(response).to redirect_to(invitations_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (renders the edit template)' do
        invitation = create(:invitation, admin: admin)
        put :update, params: { id: invitation.id, invitation: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested invitation' do
      invitation = create(:invitation, admin: admin)
      expect {
        delete :destroy, params: { id: invitation.id }
      }.to change(Invitation, :count).by(-1)
    end

    it 'redirects to the invitations list' do
      invitation = create(:invitation, admin: admin)
      delete :destroy, params: { id: invitation.id }
      expect(response).to redirect_to(invitations_path)
    end
  end
end
