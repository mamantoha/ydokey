require "spec"
require "../src/ydokey"

# Execute ydokey command with flags and return stripped output and error.
def ydokey(*args : String, env = nil)
  cmd = ["crystal #{__DIR__}/../src/cli.cr"]
  cmd.push(*args) unless args.empty?

  io_in = IO::Memory.new
  io_out = IO::Memory.new
  io_error = IO::Memory.new

  Process.run(cmd.join(" "), nil, env, false, true, io_in, io_out, io_error)

  {out: io_out.to_s.strip, error: io_error.to_s.strip}
end
