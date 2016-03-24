require "spec_helper"

describe PrettyTimeouts::ConnectionFailed do
  subject { described_class.new("foo", 3, "http://localhost:4321/api/v1/foos.json", "original message") }

  it "inherits from faraday's timeout error so it can still be caught like it" do
    expect(subject).to be_a(Faraday::Error::ConnectionFailed)
  end

  describe "message" do
    it "builds it from the name, open_timeout and url" do
      expect(subject.message).
        to eq("foo open timeout of 3s reached attempting to connect to http://localhost:4321/api/v1/foos.json. Got error: 'original message'")
    end
  end
end
