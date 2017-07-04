require 'capybara/dsl'
include Capybara::DSL 

Capybara.run_server = false
Capybara.current_driver = :selenium

def randomEmailGenerator
  random_string = Random.new_seed.to_s[0...10]
  random_string + "@gmail.com"
end

email = randomEmailGenerator

describe "User Sign Up, Sing In, Sign Out Process" do 
  it "has a link to sign up page from index" do
    visit 'http://pai-test.herokuapp.com'
    first("a[href='/users/sign_up']").click
    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password confirmation")
  end

  it "can sign up a new user" do 
    visit "http://pai-test.herokuapp.com/users/sign_up"
    fill_in "user_first_name", with: "Bruce"
    fill_in "user_last_name", with: "Wong"
    fill_in "user_email", with: email 
    fill_in "phone1", with: "510"
    fill_in "phone2", with: "209"
    fill_in "phone3", with: "9995"
    fill_in "extension-input", with: "9995"
    fill_in "user_password", with: "Hiremeplease"
    fill_in "user_password_confirmation", with: "Hiremeplease"
    find("input[name='commit']").click 
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  it "can log a user out" do 
    visit 'http://pai-test.herokuapp.com'
    find("a[href='/users/sign_out']").click
    expect(page).to have_content("Signed out successfully.")
  end

  it "can log a user in" do 
    visit 'http://pai-test.herokuapp.com'
    first("a[href='/users/sign_in']").click
    fill_in "user_email", with: email 
    fill_in "user_password", with: "Hiremeplease"
    find("input[name='commit']").click 
    expect(page).to have_content("Signed in successfully")
  end

end

