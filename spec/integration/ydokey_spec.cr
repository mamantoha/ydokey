require "../spec_helper"

describe "ydokey command" do
  context "passing flag arguments" do
    it "returns an error for no arguments" do
      ydokey("")[:error].should contain("ERROR: wrong arguments")
    end

    it "returns an error for invalid option" do
      ydokey("-X")[:error].should contain("ERROR: -X is not a valid option")
    end

    it "returns an error for missing option" do
      ydokey("-k")[:error].should contain("ERROR: missing option for -k")
    end

    it "returns the help menu for option -h" do
      ydokey("-h")[:out].should contain("ydokey [arguments]")
    end

    it "returns a version for option -v" do
      ydokey("-v")[:out].should eq(Ydokey::VERSION)
    end

    it "returns raw key codes for option -k" do
      ydokey("-k", "Ctrl+Alt")[:out].should eq("29:1 56:1 29:0 56:0")
    end

    it "returns the error message for unknown key" do
      ydokey("-k", "Ctrl+Alt+Del")[:error].should eq("Unknown key 'del' in 'Ctrl+Alt+Del'")
    end
  end
end
