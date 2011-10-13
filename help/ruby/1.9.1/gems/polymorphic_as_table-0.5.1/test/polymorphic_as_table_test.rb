require 'test_helper'

class PolymorphicAsTableTest < ActiveSupport::TestCase
  load_schema

  class Picture < ActiveRecord::Base
    is_polymorphic_as_table
    belongs_to :imageable, :polymorphic => true
  end

  class Employee < ActiveRecord::Base
    has_polymorphic_as_table
    has_many :pictures, :as => :imageable
  end

  def test_schema_has_loaded_correctly
    assert_equal [], Picture.all
    assert_equal [], Employee.all
  end

  def test_type_is_written_as_table_name
    e = Employee.create(:name => "JimBob")
    p = e.pictures.create(:name => "picture1")

    sql = "SELECT imageable_type from `pictures` where imageable_id=%d"
    type = ActiveRecord::Base.connection.select_value(sql %e.id)
    assert_equal("employees", type)
  end

  def test_type_is_read_as_class_name
    e = Employee.create(:name => "JimBob")
    p = e.pictures.create(:name => "picture1")
    assert_equal("Employee", p.imageable_type)
  end
end
