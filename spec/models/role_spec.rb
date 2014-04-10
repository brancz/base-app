require 'spec_helper'

describe Role do
  it "has a number of users" do
    role = Role.find_by_internal_name("user")
    role.users_count.should == 1
  end

  it "has one user assiciated if it is created" do
    role = Role.find_by_internal_name("user")
    user = FactoryGirl.create(:user)
    role.users_count.should == 2 # user role is default from user created above + default created admin
  end
end
