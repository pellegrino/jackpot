RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

module SignInHelpers

  def sign_in(user)
    visit        new_user_session_path
    fill_in      'Email',    :with => user.email
    fill_in      'Password', :with => 'password'
    click_button 'Sign in'
  end

  def sign_out
    click_link 'Sign out'
  end
end

RSpec.configure do |c|
  c.include SignInHelpers, :type => :request
end
