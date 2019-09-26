class ClockEntryPresenter < ApplicationPresenter
  def date
    @model.created_at.strftime('%F')
  end

  def day_of_the_month
    @model.created_at.strftime('%A')
  end

  def time_in
    return unless @model.time_in

    @model.time_in.strftime('%T %p')
  end

  def time_out
    return unless @model.time_out

    @model.time_out.strftime('%T %p')
  end

  def total_time_used
    return unless @model.time_out

    time_difference = (@model.time_out - @model.time_in)
    Time.at(time_difference).utc.strftime '%H:%M:%S'
  end
end