class Sqlite3Preparer
  def initialize
    @statement = prepared_statement
  end

  def execute(*args)
    statement.execute(args)
  end

  def close
    statement.close
  end

  protected

  attr_reader :statement

  def sql
    "INSERT INTO people ('height', 'weight', 'gender', 'created_at', 'updated_at')" +
    "  VALUES (?, ?, ?, DATETIME('now'), DATETIME('now'))"
  end

  def prepared_statement
    ActiveRecord::Base.connection.raw_connection.prepare(self.sql)
  end
end