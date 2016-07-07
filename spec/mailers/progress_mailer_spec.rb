require "rails_helper"

RSpec.describe ProgressMailer, type: :mailer do
  describe "send_progress" do
    let(:mail) { ProgressMailer.send_progress }

    it "renders the headers" do
      expect(mail.subject).to eq("Send progress")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
