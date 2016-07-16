require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe "send_reminder" do
    let(:mail) { ReminderMailer.send_reminder }

    it "renders the headers" do
      expect(mail.subject).to eq("Send reminder")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
