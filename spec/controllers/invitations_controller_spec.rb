require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:company) { create(:company) }
  let(:valid_attributes) { attributes_for(:invitation, company_id: company.id) }
  let(:invalid_attributes) { attributes_for(:invitation, email: 'invalid_email') }

  before { sign_in admin }

  describe 'GET #index' do
    let!(:my_invitation) { create(:invitation, admin: admin, name: 'My Invitation') }
    let!(:other_admin_invitation) { create(:invitation, admin: create(:admin), name: 'Other Invitation') }

    context 'without filters' do
      it 'lists only invitations from current admin' do
        get :index
        expect(assigns(:invitations)).to include(my_invitation)
        expect(assigns(:invitations)).not_to include(other_admin_invitation)
      end
    end

    context 'with name filter' do
      let!(:matching_invitation) { create(:invitation, admin: admin, name: 'Target Name') }
      let!(:non_matching_invitation) { create(:invitation, admin: admin, name: 'Other Name') }

      it 'returns filtered invitations' do
        get :index, params: { name: 'Target' }
        expect(assigns(:invitations)).to include(matching_invitation)
        expect(assigns(:invitations)).not_to include(non_matching_invitation)
      end
    end

    context 'with company filter' do
      let!(:company_invitation) { create(:invitation, admin: admin, company: company) }
      let!(:other_invitation) { create(:invitation, admin: admin) }

      it 'returns invitations for specific company' do
        get :index, params: { company_id: company.id }
        expect(assigns(:invitations)).to include(company_invitation)
        expect(assigns(:invitations)).not_to include(other_invitation)
      end
    end

    context 'with date range filter' do
      let(:new_invitation) { create(:invitation, admin: admin, company: company, created_at: "2025-01-27") }
      let(:old_active_invitation) { create(:invitation, admin: admin, company: company, created_at: "2025-01-25") }
      let(:old_disabled_invitation) do
        create(:invitation, admin: admin, company: company, created_at: "2025-01-20", disable_at: "2025-01-21")
      end

      it "returns invitations within date range" do
        get :index, params: {
          start_date: "2025-01-27",
          end_date: "2025-01-31"
        }

        expect(assigns(:invitations)).to include(new_invitation)
        expect(assigns(:invitations)).to include(old_active_invitation)
        expect(assigns(:invitations)).not_to include(old_disabled_invitation)
      end
    end

    context 'with multiple filters' do
      let(:company) { create(:company) }
      let!(:matching_invitation) do
        create(:invitation,
          admin: admin,
          name: 'Target Invitation',
          company: company,
          created_at: Time.current
        )
      end
      let!(:non_matching_invitation) do
        create(:invitation,
          admin: admin,
          name: 'Other Invitation',
          created_at: 2.days.ago
        )
      end

      it 'returns invitations matching all criteria' do
        get :index, params: {
          name: 'Target',
          company_id: company.id,
          start_date: Date.current.to_s,
          end_date: Date.current.to_s
        }

        expect(assigns(:invitations)).to include(matching_invitation)
        expect(assigns(:invitations)).not_to include(non_matching_invitation)
      end
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
