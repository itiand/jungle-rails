require 'rails_helper'

RSpec.describe User, type: :model do
  

  describe "Validation" do
    #password and password_confirmation need to exist
    it 'should not save if either password or password_confirmation is nil' do

      user = User.new(
        first_name: 'Chris',
        last_name: 'Hawkins',
        email: 'c@yahoo.com',
        password: '',
        password_confirmation: ''
      )

      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    #need to match
    it 'should not save if password and password_confirmation do not match' do
      user = User.new(
        first_name: 'Chris',
        last_name: 'Hawkins',
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
      first_name: 'Chris',
      last_name: 'Hawkins',
      email: 'test4@test.com',
      password: 'password',
      password_confirmation: 'password'
    )

    user = User.new(
    first_name: 'Chris',
    last_name: 'Hawkins',
    email: 'TEST4@TeST.com',
    password: 'password',
    password_confirmation: 'password'
    )

    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Email has already been taken")
  end

  #email, first name, last name
  it 'should not save if either email, first name, last name are missing' do
    user = User.new(
      first_name: nil,
      last_name: nil,
      email: nil,
      password: 'password',
      password_confirmation: 'password'
    )

    expect(user.save).to be false
    expect(user.errors.full_messages).to include(
      "First name can't be blank",
      "Last name can't be blank",
      "Email can't be blank"
      )
  end

  it 'should not save if the password is less than 6 characters' do
    user = User.new(
      first_name: 'Chris',
      last_name: 'Hawkins',
      email: 'chris@yahoo.com',
      password: 'short',
      password_confirmation: 'short'
    )

    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates user with correct credentials' do
      user = User.create!(
        first_name: 'Chris',
        last_name: 'Angela',
        email: 'aChris@aol.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('aChris@aol.com','password')
      expect(authenticated_user).to eql(user)
    end

    it 'does not authenticate with incorrect credentials' do
      user = User.create!(
        first_name: 'Chris',
        last_name: 'Angela',
        email: 'aChris@aol.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('aChris@aol.com', 'somepassword')
      expect(authenticated_user).to eql(nil)
    end
  end
end
