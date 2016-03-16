require "spec_helper"

describe PrettyTimeouts::Middleware do
  subject { described_class.new(app, "foo")}

  context "a timeout error occurs" do
    let(:env) {{
      request: { timeout: 2 },
      url: "http://localhost:4321/api/v1/foos.json"
    }}
    let(:app) { ->(env) { raise error }}
    let(:error) { Faraday::Error::TimeoutError.new }

    describe "the error that is raised" do
      it "re-raises a pretty timeout error with a pretty message" do
        expect { subject.call(env) }.
          to raise_error(PrettyTimeouts::TimeoutError,
                         "foo timeout of 2s reached attempting to connect to http://localhost:4321/api/v1/foos.json")
      end

      it "uses the same backtrace as the raised error" do
        raised_error = subject.call(env) rescue $!
        expect(raised_error.backtrace).to eq(error.backtrace)
      end
    end
  end
end
