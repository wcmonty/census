class PostgresqlPreparer
  def initialize
    @name = 'insert_person'
    @statement = prepared_statement
  end

  def execute(*args)
    connection.exec_prepared(name, args)
  end

  def close
    connection.exec("DEALLOCATE #{name}")
  end

  protected

  attr_reader :name, :statement

  def sql
    "INSERT INTO people (height, weight, gender, created_at, updated_at)" +
    "  VALUES ($1, $2, $3, now(), now())"
  end

  def connection
    @connection ||= ActiveRecord::Base.connection.raw_connection
  end

  def prepared_statement
    connection.prepare(name, sql)
  end
end