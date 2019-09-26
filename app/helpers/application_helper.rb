module ApplicationHelper
  def flash_messages_for(object)
    render(partial: 'shared/flash_messages', locals: { object: object })
  end

  def present(model, presenter_class = nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end
end
