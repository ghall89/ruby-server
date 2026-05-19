# frozen_string_literal: true

class Reply
  attr_reader :id, :user_id, :post_id, :parent_id, :body

  def initialize(row)
    @id = row["id"]
    @created_at = row["created_at"]
    @updated_at = row["updated_at"]
    @user_id = row["user_id"]
    @post_id = row["post_id"]
    @parent_id = row["parent_id"]
    @body = row["body"]
  end

  def self.all
    DB.execute("SELECT * FROM replies").map { |row| new(row) }
  end

  def self.all_by_user_id(user_id)
    DB.execute("SELECT * FROM replies WHERE user_id = ?", user_id).map { |row| new(row) }
  end

  def self.all_by_post_id(post_id)
    replies = DB.execute("SELECT * FROM replies WHERE post_id = ?", post_id).map { |row| new(row) }
    nest(replies)
  end

  def self.all_by_parent_id(parent_id)
    DB.execute("SELECT * FROM replies WHERE parent_id = ?", parent_id).map { |row| new(row) }
  end

  def self.find(id)
    row = DB.execute("SELECT * FROM replies WHERE id = ?", id).first
    row ? new(row) : nil
  end

  def self.create(user_id, post_id, parent_id, body)
    DB.execute(
      "INSERT INTO replies (user_id, post_id, parent_id, body) VALUES (?, ?, ?, ?)",
      [user_id, post_id, parent_id, body]
    )
    new_id = DB.last_insert_row_id
    find(new_id)
  end

  def self.update(id, body)
    DB.execute("UPDATE replies SET body = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?", [body, id])
  end

  def self.delete(id)
    DB.execute("DELETE FROM replies WHERE id = ?", [id])
  end

  def self.nest(items, parent_id = nil)
    puts items.map { |i| "id: #{i.id.class}, parent_id: #{i.parent_id.class}" }
    items
      .select { |i| i.parent_id == parent_id }
      .map { |i| { item: i, children: nest(items, i.id) } }
  end
end
