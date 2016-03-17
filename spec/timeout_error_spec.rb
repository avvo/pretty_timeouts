require "spec_helper"

describe PrettyTimeouts::TimeoutError do
  subject { described_class.new("foo", 2, "http://localhost:4321/api/v1/foos.json") }

  it "inherits from faraday's timeout error so it can still be caught like it" do
    expect(subject).to be_a(Faraday::Error::TimeoutError)
  end

  describe "message" do
    it "builds it from the name, timeout and url" do
      expect(subject.message).
        to eq("foo timeout of 2s reached attempting to connect to http://localhost:4321/api/v1/foos.json")
    end
  end
end
