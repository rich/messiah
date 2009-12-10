require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Messiah::Config do
  let(:config) {Messiah::Config.new}

  it "responds to any method name" do
    config.should respond_to(:foo)
  end

  it "accepts setters by any name" do
    lambda {config.foo = 10}.should_not raise_error
  end

  it "remembers values for any of it's previous assignments" do
    config.foo 10
    config.foo.should == 10
  end

  it "removes equal signs from the keys of setters" do
    config.foo = 10
    config.foo.should == 10
  end

  it "accepts blocks as values" do
    config.foo {10}
    config.foo.call.should == 10
  end
end
