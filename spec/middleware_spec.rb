require "spec_helper"
require "net/http/persistent"

describe PrettyTimeouts::Middleware do
  subject { described_class.new(app, "foo")}

  let(:env) {{
    request: { timeout: 2, open_timeout: 3 },
    url: "http://localhost:4321/api/v1/foos.json"
  }}
  let(:app) { ->(env) { raise error }}

  context "a timeout error occurs" do
    let(:error) { Faraday::Error::TimeoutError.new }

    describe "the error that is raised" do
      it "re-raises a pretty timeout error with a pretty message" do
        expect { subject.call(env) }.
          to raise_error(PrettyTimeouts::TimeoutError,
                         "foo timeout of 2s reached attempting to connect to http://localhost:4321/api/v1/foos.json")
      end
    end
  end

  context "ConnectionFailed" do
    context "Net::OpenTimeout" do
      let(:error) { Faraday::Error::ConnectionFailed.new(Net::OpenTimeout.new('execution expired')) }

      describe "the error that is raised" do
        it "re-raises a pretty connection failed error with a pretty message" do
          expect { subject.call(env) }.
            to raise_error(PrettyTimeouts::ConnectionFailed,
                           "foo open timeout of 3s reached attempting to connect to http://localhost:4321/api/v1/foos.json. Got error: 'execution expired'")
        end
      end
    end

    context "Errno::ECONNREFUSED" do
      let(:error) { Faraday::Error::ConnectionFailed.new(Errno::ECONNREFUSED.new('nope')) }

      describe "the error that is raised" do
        it "re-raises a pretty connection failed error with a pretty message" do
          expect { subject.call(env) }.
            to raise_error(PrettyTimeouts::ConnectionFailed,
                           "foo open timeout of 3s reached attempting to connect to http://localhost:4321/api/v1/foos.json. Got error: 'Connection refused - nope'")
        end
      end
    end

    context "'connection refused'" do
      let(:error) { Faraday::Error::ConnectionFailed.new(Net::HTTP::Persistent::Error.new('connection refused')) }

      describe "the error that is raised" do
        it "re-raises a pretty connection failed error with a pretty message" do
          expect { subject.call(env) }.
            to raise_error(PrettyTimeouts::ConnectionFailed,
                           "foo open timeout of 3s reached attempting to connect to http://localhost:4321/api/v1/foos.json. Got error: 'connection refused'")
        end
      end
    end
  end
end
