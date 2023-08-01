require 'rails_helper'

RSpec.describe User, type: :model do
  

  describe "Validation" do
    #password and password_confirmation need to exist
    it 'should not save if either password or password_confirmation is nil' do

      user = User.new(email: 'c@yahoo.com',
        password: '',
        password_confirmation: ''
      )

      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    #need to match
    it 'should not save if password and password_confirmation do not match' do
      user = User.new(
        email: 'd@yahoo.com',
        password: 'password',
        password_confirmation: 'wrongPass'
      )

      expect(user.save).to be false
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  #case sensitive of email?
  it 'validates uniqueness of email' do
    User.create!(
      email: 'test1@test.com',
      password: 'password',
      password_confirmation: 'password'
    )

    user = User.new(
    email: 'TEST1@TeST.com',
    password: 'password',
    password_confirmation: 'password'
    )

    expect(user).to_not be_valid
  end

  #email, first name, last name


end
