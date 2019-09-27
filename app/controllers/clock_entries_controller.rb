class ClockEntriesController < ApplicationController
  include StrictQueries::Concern

  before_action :set_clock_entry, only: [:show, :edit, :update, :destroy, :clock_out]
  before_action :authenticate_user!

  def index
    @clock_entries = current_user.active_clock_entries.load
  end

  def new
    @clock_entry = ClockEntry.new
  end

  def edit; end

  def show; end

  def create
    @clock_entry = current_user.clock_entries.new(clock_entry_params)
    @clock_entry.set_time_in

    respond_to do |format|
      if @clock_entry.save
        format.html { redirect_to @clock_entry, notice: 'Clock entry was successfully created.' }
        format.js { redirect_to root_path, notice: 'Clock entry was successfully created.' }
        format.json { render :show, status: :created, location: @clock_entry }
      else
        format.js { render :new }
        format.html { render :new }
        format.json { render json: @clock_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @clock_entry.update(clock_entry_params)
        format.js { redirect_to root_path, notice: 'Clock entry was successfully updated.' }
        format.html { redirect_to @clock_entry, notice: 'Clock entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @clock_entry }
      else
        format.js { render :edit }
        format.html { render :edit }
        format.json { render json: @clock_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @clock_entry.destroy
    respond_to do |format|
      format.js { redirect_to root_path, notice: 'Clock entry was successfully destroyed.' }
      format.html { redirect_to clock_entries_url, notice: 'Clock entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def clock_out
    @clock_entry.update_attribute(:time_out, Time.now)
    @clock_entry.save
    respond_to do |format|
      format.html { redirect_to root_path(@clock_entry), notice: 'You have clocked out successfully.' }
      format.js { redirect_to root_path(@clock_entry), notice: 'You have clocked out successfully.' }
    end
  end

  private

  def set_clock_entry
    @clock_entry = ClockEntry.find(params[:id])
  end

  def clock_entry_params
    params.require(:clock_entry).permit(:user_id, :purpose, :time_in, :time_out)
  end
end