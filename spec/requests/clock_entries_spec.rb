# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ClockEntry', type: :request do
  describe '#create' do
    context '#when logged in' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'renders new form' do
        get root_path
        get new_clock_entry_path
        expect(response).to render_template(:new)
      end

      it 'creates a clock entry' do
        post clock_entries_path, params: { clock_entry: { user: @user, purpose: 'Meeting' }, format: :json }
        expect(response).to have_http_status(:created)
      end

      it 'changes clock entries by 1' do
        expect do
          post clock_entries_path, params: { clock_entry: { user: @user, purpose: 'Meeting' }, format: :json }
        end.to change(ClockEntry, :count).by(1)
      end
    end

    context '#when not logged in' do
      it 'redirects to signin page' do
        get root_path
        get new_clock_entry_path
        expect(response.status).to eq 302
      end

      it 'returns unauthenticated' do
        post clock_entries_path, params: { clock_entry: { user: @user, purpose: 'Meeting' }, format: :json }
        expect(response.status).to eq 401
      end

      it "doesn't create new entry" do
        expect do
          post clock_entries_path, params: { clock_entry: { user: @user, purpose: 'Meeting' }, format: :json }
        end.not_to change(ClockEntry, :count)
      end
    end
  end
end