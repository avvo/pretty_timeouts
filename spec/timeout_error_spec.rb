require "spec_helper"

describe PrettyTimeouts::TimeoutError do
  it "inherits from faraday's timeout error so it can still be caught like it" do
    expect(subject).to be_a(Faraday::Error::TimeoutError)
  end
end
