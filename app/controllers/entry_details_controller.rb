class EntryDetailsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @entry_details = pagy(current_user.inactive_clock_entries.load, items: 10)
  end
end
