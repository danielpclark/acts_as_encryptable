require 'test_helper'

class ActsAsEncryptableTest < Minitest::Test
  describe "Encryptable fields" do
    let(:raw_data) {
      {
        to: "a@b.c",
        from: "d@e.f",
        subject: "example",
        raw_body: "This will be the encrypted part."
      }
    }

    let(:my_email) { MyEmail.new( **raw_data ) }

    it "is retrievable" do
      my_email.save
      e = MyEmail.last
      _(e.raw_body).must_equal raw_data[:raw_body]
    end

    it "will read raw record data differently" do
      _(my_email.read_attribute(:raw_body)).wont_equal raw_data[:raw_body]
      _(my_email.raw_body).must_equal raw_data[:raw_body]
    end

    it "maintains consistent credentials" do
      # You should add this test for each of your own encrypted fields
      key = my_email.send :the_key
      salt = my_email.send :the_salt

      my_email.save

      t = MyEmail.where(id: my_email.id).first
      key2 = t.send :the_key
      salt2 = t.send :the_salt

      _(key).must_equal key2
      _(salt).must_equal salt2
    end
  end
end
