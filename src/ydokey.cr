module Ydokey
  extend self

  VERSION = "0.4.3"
  NAME    = "ydokey"

  enum KeyEvent
    Up   # 0
    Down # 1
  end

  class UnknownKeyError < Exception
  end

  # Input event codes
  CODES_FILE = "/usr/include/linux/input-event-codes.h"

  # See `/usr/include/linux/input-event-codes.h' for available key codes (KEY_*)
  KEY_REGEX = /#define KEY_(?<key>\w+)\s+(?<keycode>(0[xX])?[0-9a-fA-F]+).*/

  KEYS_MAP = {
    "alt"     => "leftalt",
    "ctrl"    => "leftctrl",
    "control" => "leftctrl",
    "meta"    => "leftmeta",
    "super"   => "leftmeta",
    "shift"   => "leftshift",
    "return"  => "enter",
  }

  @@key_mappings : Hash(String, Int32)?

  def codes_file
    {{ read_file(CODES_FILE) }}
  end

  def key_mappings : Hash(String, Int32)
    @@key_mappings ||=
      codes_file.lines.reduce({} of String => Int32) do |acc, line|
        if m = KEY_REGEX.match(line)
          acc[m["key"].downcase] = m["keycode"].to_i(prefix: true)
        end

        acc
      end
  end

  def list_keys : Array(String)
    KEYS_MAP.keys + key_mappings.keys
  end

  def to_key_codes(input : String) : String
    keys = input.split('+').map(&.downcase)

    key_codes = keys.reduce([] of Int32) do |acc, key|
      key = KEYS_MAP[key]? || key

      raise UnknownKeyError.new("Unknown key '#{key}' in '#{input}'") unless key_mappings.has_key?(key)

      acc << key_mappings[key]
    end

    [KeyEvent::Down, KeyEvent::Up].map(&.value).cartesian_product(key_codes).map(&.reverse).map(&.join(':')).join(' ')
  end
end
