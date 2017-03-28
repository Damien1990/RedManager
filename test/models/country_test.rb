require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  def setup
    @country = Country.new(name: "Switzerland")
  end
  
  test "country should be valid" do
    assert @country.valid?
  end
  
  test "country should be present" do
    @country.name = ""
    assert_not @country.valid?
  end
  
  test "country shouldn't be more than 40 characters" do
    @country.name = "a" * 41
    assert_not @country.valid?
  end
  
  test "country should be unique and case insensitive" do
    duplicate_country = @country.dup
    duplicate_country.name = @country.name.upcase
    @country.save
    assert_not duplicate_country.valid?
  end
end