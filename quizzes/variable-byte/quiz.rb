#!/usr/bin/env ruby
# Mike Miller, James Vannordstrand, Syth Ryan, Nigel Ploof, Kyle Hall, Shaun Meyer, Adam Shannon

def read_and_validate_arg()
  arg = ARGV[0]
  value = arg.to_i

  if value < 0
    nil
  else
    value
  end
end

def prepend(arr, value)
  [value] + arr
end

def vb_encode(n)
  bytes = []
  while true
    bytes = prepend(bytes, n % 128)
    if n < 128
      break
    end
    n = n / 128
  end

  # Not needed because we're only dealing with one number.
  # Once we switch to multiple numbers just one after another separated by
  # bits we'll need to encode the continuation bit.
  # if bytes[bytes.size] != nil
  #   bytes[bytes.size] += 128
  # end

  bytes
end

def vb_decode(arr)
  numbers = []
  n = 0
  i = 1
  # Mutable recursion, my favourite!
  while i <= arr.size
    if arr[i-1] < 128
      n = (128 * n) + arr[i-1]
    else
      n = (128 * n) + (arr[i-1] - 128)
      numbers.push(n)
      n = 0
    end
    i += 1
  end
  n
end

# need to figure out how to output raw bytes to the file.
# probably open it in a diff format.
def output_vb_encoding(enc, file_name = "vb.out")

end

# verify an output file.
def verify_vb_encoding_file(file_name = "vb.out")
  false
end

def main()
  value = read_and_validate_arg()
  puts "value: #{value}"

  vb_encoding = vb_encode(value)
  puts "vb_encode: #{vb_encoding}"

  vb_decoding = vb_decode(vb_encoding)
  puts "decoded: #{vb_decoding}"

  output_vb_encoding(vb_encoding)
  puts "verified vb_encoding_file: #{verify_vb_encoding_file()}"
end

main()
