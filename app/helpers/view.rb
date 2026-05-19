# frozen_string_literal: true

module ViewHelpers
  def partial(template, locals = {})
    erb template, layout: false, locals: locals
  end
  
  def render_replies(node)
    reply = node[:item]
    html  = "<div class='mb-3 ps-3 border-start'>"
    poster = User.find(reply.user_id)
    html += "<p>#{reply.body}</p>"
    html += "<p class='text-muted'>by: #{poster.username}</p>"
    html += "<button class='btn btn-sm btn-outline-secondary' data-reply-toggle='#{reply.id}'>Reply</button>"
    html += "<div id='reply-form-#{reply.id}' class='mt-2 d-none'>"
    html += "<form action='/replies' method='post'>"
    html += "<div class='mb-2'><textarea name='body' class='form-control' rows='3' placeholder='Write a reply...'></textarea></div>"
    html += "<input type='hidden' name='post_id' value='#{reply.post_id}' />"
    html += "<input type='hidden' name='parent_id' value='#{reply.id}' />"
    html += "<button type='submit' class='btn btn-primary btn-sm'>Reply</button>"
    html += "</form></div>"
    html += "<div class='mt-2'>"
    node[:children].each { |child| html += render_replies(child) }
    html += "</div></div>"
    html
  end
end
