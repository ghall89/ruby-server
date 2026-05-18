# frozen_string_literal: true

require "sqlite3"
require "fileutils"

DB_PATH = File.join(__dir__, "..", "db", "app.db")
FileUtils.mkdir_p(File.dirname(DB_PATH))

DB = SQLite3::Database.new(DB_PATH)
DB.results_as_hash = true

DB.execute(<<~SQL)
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_digest TEXT NOT NULL,
    remember_token TEXT
  )
SQL

DB.execute(<<~SQL)
  CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatd_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL
  )
SQL
