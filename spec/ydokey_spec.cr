require "./spec_helper"

describe Ydokey do
  context Ydokey::VERSION do
    it { Ydokey::VERSION.should_not be_nil }
  end

  context ".list_keys" do
    it "returns an array of keys" do
      list_keys = Ydokey.list_keys

      list_keys.should contain("esc")
    end
  end

  context ".key_mappings" do
    it "returns a hash" do
      key_mappings = Ydokey.key_mappings

      key_mappings["esc"].should eq(1)
      key_mappings["ok"].should eq(0x160)
    end
  end

  context ".to_key_codes" do
    it "converts a single key" do
      key_codes = Ydokey.to_key_codes("esc")

      key_codes.should eq("1:1 1:0")
    end

    it "converts a key's combination" do
      key_codes = Ydokey.to_key_codes("Ctrl+Esc")

      key_codes.should eq("29:1 1:1 29:0 1:0")
    end

    it "raises an error with unknown key" do
      expect_raises Ydokey::UnknownKeyError, "Unknown key 'del' in 'Ctrl+Alt+Del'" do
        Ydokey.to_key_codes("Ctrl+Alt+Del")
      end
    end
  end
end
