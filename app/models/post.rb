# frozen_string_literal: true

class Post
  attr_reader :id, :user_id, :title, :body

  def initialize(row)
    @id = row["id"]
    @created_at = row["created_at"]
    @updated_at = row["updated_at"]
    @user_id = row["user_id"]
    @title = row["title"]
    @body = row["body"]
  end

  def self.all
    DB.execute("SELECT * FROM posts").map { |row| new(row) }
  end

  def self.all_by_user_id(user_id)
    DB.execute("SELECT * FROM posts WHERE user_id = ?", user_id).map { |row| new(row) }
  end

  def self.find(id)
    row = DB.execute("SELECT * FROM posts WHERE id = ?", id).first
    row ? new(row) : nil
  end

  def self.create(user_id, title, body)
    DB.execute("INSERT INTO posts (user_id, title, body) VALUES (?, ?, ?)", [user_id, title, body])
    new_id = DB.last_insert_row_id
    find(new_id)
  end

  def self.update(id, title, body)
    DB.execute("UPDATE posts SET title = ?, body = ?, updated_at = CURRENT TIMESTAMP WHERE id = ?", [title, body, id])
  end

  def self.delete(id)
    DB.execute("DELETE FROM posts WHERE id = ?", [id])
  end
end
