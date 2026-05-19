# frozen_string_literal: true

module ViewHelpers
  def partial(template, locals = {})
    erb template, layout: false, locals: locals
  end
end
