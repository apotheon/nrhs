def sign_in user=nil, password='password'
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: password
  click_button 'Log In'
end
