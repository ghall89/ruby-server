# frozen_string_literal: true

require "bcrypt"

class User
  attr_reader :id, :username

  def initialize(row)
    @id = row["id"]
    @username = row["username"]
    @password_digest = row["password_digest"]
  end

  def self.find(id)
    row = DB.execute("SELECT * FROM users WHERE id = ?", id).first
    row ? new(row) : nil
  end

  def self.find_by_username(username)
    row = DB.execute("SELECT * FROM users WHERE username = ?", username).first
    row ? new(row) : nil
  end

  def self.find_by_remember_token(token)
    return nil if token.nil? || token.empty?

    row = DB.execute("SELECT * FROM users WHERE remember_token = ?", token).first
    row ? new(row) : nil
  end

  def self.create(username, password)
    digest = BCrypt::Password.create(password)
    DB.execute("INSERT INTO users (username, password_digest) VALUES (?, ?)", [username, digest])
    find_by_username(username)
  end

  def authenticate(password)
    BCrypt::Password.new(@password_digest) == password
  end

  def save_remember_token(token)
    DB.execute("UPDATE users SET remember_token = ? WHERE id = ?", [token, @id])
  end

  def clear_remember_token
    DB.execute("UPDATE users SET remember_token = NULL WHERE id = ?", @id)
  end

  def to_h
    { id: @id, username: @username }
  end
end
