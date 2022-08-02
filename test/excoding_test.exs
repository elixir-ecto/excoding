defmodule ExcodingTest do
  use ExUnit.Case
  import Excoding
  doctest Excoding

  test "should decode string correctly" do
    assert "caf\u00e9" == decode(<<99, 97, 102, 233>>, "iso-8859-1")

    assert "Hello, 世界!" ==
             decode(<<72, 101, 108, 108, 111, 44, 32, 225, 166, 205, 163, 33>>, "windows-949")

    assert <<158, 232, 240, 232, 235, 232, 246, 224>> = encode("ћирилица", "windows-1251")
    assert "ћирилица" = decode(<<158, 232, 240, 232, 235, 232, 246, 224>>, "windows-1251")
  end

  test "should decode broken string and replace unkinwn with `�` code" do
    assert "\u{c6b0}\u{c640}\u{fffd}\u{c559}" ==
             decode(<<0xBF, 0xEC, 0xBF, 0xCD, 0xFF, 0xBE, 0xD3>>, "windows-949")

    # same encoding/decoding as above but ecoding name is different
    assert "\u{c6b0}\u{c640}\u{fffd}\u{c559}" ==
             decode(<<0xBF, 0xEC, 0xBF, 0xCD, 0xFF, 0xBE, 0xD3>>, "euc-kr")
  end
end
