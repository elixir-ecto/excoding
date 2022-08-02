defmodule Excoding do
  @moduledoc """
  String encoding/decoding library with NIF binding to rust [endcoding]() crate.

  Supported encodings:

  * 7-bit strict ASCII (`ascii`)
  * UTF-8 (`utf-8`)
  * UTF-16 in little endian (`utf-16` or `utf-16le`) and big endian (`utf-16be`)
  * All single byte encoding in WHATWG Encoding Standard:
    * IBM code page `ibm-866`
    * ISO 8859-{2,3,4,5,6,7,8,10,13,14,15,16}
    * KOI8-R, KOI8-U
    * MacRoman (`macintosh`), Macintosh Cyrillic encoding (`x-mac-cyrillic`)
    * Windows code pages `windows-874`, `windows-1250`, `windows-1251`, `windows-1252`
    (instead of ISO 8859-1), `windows-1253`, `windows-1254` (instead of ISO 8859-9),
    `windows-1255`, `windows-1256`, `windows-1257`, `windows-1258`
  * All multi byte encodings in WHATWG Encoding Standard:
    * Windows code page `windows-949` (`euc-kr`, since the strict EUC-KR is hardly used)
    * EUC-JP (`euc-jp`) and Windows code page `windows-932` (`shift_jis`, since it's the most widespread extension to Shift_JIS)
    * ISO-2022-JP (`iso-2022-jp`) with asymmetric JIS X 0212 support (Note: this is not yet up to date to the current standard)
    * GBK
    * GB 18030
    * Big5-2003 with HKSCS-2008 extensions
  * Encodings that were originally specified by WHATWG Encoding Standard:
    * HZ
    * ISO 8859-1 (`iso-8859-1` distinct from Windows code page `windows-1255`)


  ### Example

      iex> Excoding.encode("¥₪ש", "windows-1255")
      <<0xA5, 0xA4, 0xF9>>
      iex> Excoding.decode(<<0xA5, 0xA4, 0xF9>>, "windows-1255")
      "¥₪ש"
  """
  use Rustler,
    otp_app: :excoding,
    crate: "excoding",
    mode: if(Mix.env() == :prod, do: :release, else: :debug)

  @doc """
  Encodes utf-8 string using given codepage. If there are any unknown codes they
  will be converted into `?` in its place.
  """
  @spec encode(string :: binary, codepage :: binary) :: binary
  def encode(_string, _codepage), do: error()

  @doc """
  Decodes given binary from given codepage into utf-8 string.
  """
  @spec decode(binary :: binary, codepage :: binary) :: binary
  def decode(_binary, _codepage), do: error()

  @doc false
  def error(), do: :erlang.nif_error(:nif_not_loaded)
end
