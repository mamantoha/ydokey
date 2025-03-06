require "option_parser"
require "./ydokey"

option_parser = OptionParser.parse do |parser|
  parser.banner = <<-BANNER
    NAME
        #{Ydokey::NAME} - command-line utility to convert key commands to raw keycodes which used in ydotool

    VERSION
        #{Ydokey::VERSION}

    SYNOPSIS
        #{Ydokey::NAME} [arguments]

        You can use #{Ydokey::NAME} together with ydotool

        ydotool key $(#{Ydokey::NAME} -k Ctrl+Meta+Right)

    ARGUMENTS
    BANNER

  parser.on("-k COMMAND", "--key=COMMAND", "Specifies the key command (e.g. Ctrl+F1, Alt+Tab, Ctrl+Shift+Meta+Right, VolumeUp, etc)") do |input|
    puts Ydokey.to_key_codes(input)
    exit
  rescue ex : Ydokey::UnknownKeyError
    STDERR.puts ex.message
    exit(1)
  end

  parser.on("-l", "--list", "List available keys codes") do
    Ydokey.list_keys.each { |k| puts k }
    exit
  end

  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end

  parser.on("-v", "--version", "Print program version") do
    default_target = Crystal::DESCRIPTION.split.last
    release_date = {{ `date -R`.stringify.chomp }}

    puts "ydokey #{Ydokey::VERSION} (#{default_target}) crystal/#{Crystal::VERSION}"
    puts "Release-Date: #{Time.parse_rfc2822(release_date).to_s("%Y-%m-%d")}"

    exit
  end

  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option"
    exit(1)
  end

  parser.missing_option do |flag|
    STDERR.puts "ERROR: missing option for #{flag}"
    exit(1)
  end
end

option_parser.parse
STDERR.puts "ERROR: wrong arguments"
STDERR.puts "For a short summary of all commands, run '#{Ydokey::NAME} --help'"
exit(1)
