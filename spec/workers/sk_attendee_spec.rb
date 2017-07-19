require File.dirname(__FILE__) + '/../../spec_helper'

describe SkAttendee do
  before :each do
    @sk = SkAttendee.new
  end

  it "should not raise" do
    @sk.some_event(1)
  end

end
