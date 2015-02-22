class PostgresqlPreparer
  def initialize
    @statement = prepared_statement
  end

  def execute(*args)
    statement.exec_prepared(args)
  end

  def close
    statement.close
  end

  protected

  attr_reader :statement

  def sql
    "INSERT INTO people (height, weight, gender, created_at, updated_at)" +
    "  VALUES ($1, $2, $3, now(), now())"
  end

  def prepared_statement
    ActiveRecord::Base.connection.raw_connection.prepare('insert_person', self.sql)
  end
end