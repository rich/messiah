require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Messiah" do
  let(:body) {last_response.body}

  before(:each) do
    host "example.dev"
  end
  
  it "should accept headers" do
    header "NOPE", "woohoo"
    visit "index.php"
    body.should contain("woohoo")
  end
  
  it "visits the page" do
    request("index.php").should be_ok
  end

  it "doesn't respond positively to unknown files" do
    request("nope.php").should_not be_ok
  end
  
  it "clicks a link" do
    visit "index.php"
    click_link "Click Me"
    body.should contain "another page"
  end
  
  it "handles cookies properly" do
    visit "index.php"
    click_link "Click Me"
    body.should contain "Hello thing"
  end
  
  it "handles redirects" do
    visit "redirector.php"
    body.should contain "arrived"
  end
  
  it "sets the host dynamically" do
    host "example-two.dev"
    visit "index.php"
    body.should contain "Host is example-two.dev"
  end
  
  it "sets the host statically" do
    visit "index.php"
    body.should contain "Host is example.dev"
  end
  
  it "handles post variables" do
    visit "form.php"
    fill_in "name", :with => 'Rich'
    click_button "Submit"
    body.should contain "Your name is Rich"
  end
  
  it "handles get variables" do
    visit "get_vars.php?first_name=Rich&last_name=Cavanaugh"
    body.should contain "Your name is Rich Cavanaugh"
  end
  
  it "handles file uploads" do
    visit "uploader.php"
    attach_file "File", __FILE__, "text/ruby"
    click_button "Upload"
    body.should contain "[uploaded_file]"
  end

  it "handles environments that drive every request through one script" do
    Messiah.script 'path_info.php'
    visit '/hello/there'
    body.should contain '/hello/there'
  end
end

