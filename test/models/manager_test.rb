require 'test_helper'

class ManagerTest < ActiveSupport::TestCase
  def setup
    @country = Country.create!(name: "Testland")
    @manager = @country.managers.build(username: "test", email: "test@example.com", 
                                       first_name: "test", last_name: "test", 
                                       dob: "1990-11-18", online: false, show_name: true,
                                       password: "testpw", password_confirmation: "testpw")
  end
  
  test "manager should be valid" do
    assert @manager.valid?
  end
  
  test "username should be present" do
    @manager.username = ""
    assert_not @manager.valid?
  end
  
  test "username should be greater than 3 characters" do
    @manager.username = "a" * 2
    assert_not @manager.valid?
  end
  
  test "username should be less than 16 characters" do
    @manager.username = "a" * 17
    assert_not @manager.valid?
  end
  
  test "username should allow alphanumeric characters" do
    valid_usernames = %w[test test01 010]
    valid_usernames.each do |valids|
      @manager.username = valids
      assert @manager.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid usernames" do
    invalid_usernames = %w[te-st Test +test 09&]
    invalid_usernames.each do |invalids|
      @manager.username = invalids
      assert_not @manager.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "should reject blacklisted usernames" do
    blacklisted_usernames = %w[fuck shit bollocks]
    blacklisted_usernames.each do |blacklisted|
      @manager.username = blacklisted
      assert_not @manager.valid?, "#{blacklisted.inspect} should be blacklisted"
    end
  end
  
  test "username should be unique" do
    duplicate_manager = @manager.dup
    @manager.save
    assert_not duplicate_manager.valid?
  end
  
  test "email should be present" do
    @manager.email = ""
    assert_not @manager.valid?
  end
  
  test "email should not be too long" do
    @manager.email = "a" * 245 + "@example.com"
    assert_not @manager.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com DAMIEN@gmail.com D.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @manager.email = valids
      assert @manager.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid addresses" do
    invalid_emails = %w[damien@example damien@example,com damien.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @manager.email = invalids
      assert_not @manager.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case insensitive" do
    duplicate_manager = @manager.dup
    duplicate_manager.email = @manager.email.upcase
    @manager.save
    assert_not duplicate_manager.valid?
  end
  
  test "first name should be present" do
    @manager.first_name = ""
    assert_not @manager.valid?
  end
  
  test "first name should be at least 2 characters" do
    @manager.first_name = "a" * 1
    assert_not @manager.valid?
  end
  
  test "first name should be less than 36 characters" do
    @manager.first_name = "a" * 36
    assert_not @manager.valid?
  end
  
  test "first name should accept correct format" do
    valid_fn = %w[Te Test TEST 'Te st']
    valid_fn.each do |valids|
      @manager.first_name = valids
      assert @manager.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "first name should reject invalid characters" do
    invalid_fn = %w[TEST! T3ST]
    invalid_fn.each do |invalids|
      @manager.first_name = invalids
      assert_not @manager.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "last name doesn't need to be present" do
    @manager.last_name = ""
    assert @manager.valid?
  end
  
  test "last name should be less than 36 characters" do
    @manager.last_name = "a" * 36
    assert_not @manager.valid?
  end
  
  test "last name should accept correct format" do
    valid_ln = %w[Te Test TEST 'Te st']
    valid_ln.each do |valids|
      @manager.last_name = valids
      assert @manager.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "last name should reject invalid characters" do
    invalid_ln = %w[TEST! T3ST]
    invalid_ln.each do |invalids|
      @manager.last_name = invalids
      assert_not @manager.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "date of birth should be present" do
    @manager.dob = ""
    assert_not @manager.valid?
  end

  test "date of birth should be at least five years old" do
    @manager.dob = "2014-04-09"
    assert_not @manager.valid?
  end
  
  test "date of birth should be at most 120 years old" do
    @manager.dob = "1830-04-09"
    assert_not @manager.valid?
  end
  
  test "online needs to be true or false" do
    @manager.online = ""
    assert_not @manager.valid?
  end
  
  test "show name needs to be true or false" do
    @manager.show_name = ""
    assert_not @manager.valid?
  end
  
  test "manager without country should be invalid" do
    @manager.country_id = nil
    assert_not @manager.valid?
  end
  
  test "password should be present" do
    @manager.password = @manager.password_confirmation = " "
    assert_not @manager.valid?
  end
  
  test "password should be atleast 5 character" do
    @manager.password = @manager.password_confirmation = "x" * 4
    assert_not @manager.valid?
  end

end