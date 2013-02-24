require 'spec_helper'

describe 'Friendly forwarding' do
  
  it 'should forward the user to the intended destination' do
    
    user = Factory(:user)
    visit edit_user_path(user)
    
    # will get redirected to sign-in.  tests follow the redirect)
    fill_in "session[email]", :with => user.email
    fill_in "session[password]", :with =>user.password
    click_button
    
    response.should render_template('users/edit')
    
  end
end
