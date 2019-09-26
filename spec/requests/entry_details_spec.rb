# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EntryDetail', type: :request do
  describe '#index' do
    context 'when logged in' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'should returns a 200 response' do
        get entry_details_index_path
        expect(response).to have_http_status '200'
      end

      it 'should render entry details index page' do
        get entry_details_index_path
        expect(response).to render_template(:index)
      end
    end

    context 'when not logged in' do
      it 'redirects to signin page' do
        get root_path
        get entry_details_index_path
        expect(response.status).to eq 302
      end
    end
  end
end