# frozen_string_literal: true

module ViewHelpers
  def partial(template, locals = {})
    erb template, layout: false, locals: locals
  end
  
  def render_replies(node)
    html = "<div class='card mb-2'><div class='card-body'>"
    html += "<p>#{node[:item].body}</p>"
    html += "<div class='ms-4'>"
    node[:children].each { |child| html += render_replies(child) }
    html += "</div></div></div>"
    html
  end
end
