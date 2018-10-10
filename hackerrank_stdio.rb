def main
  input1 = []
  input2 = []

  # Read file
  rawline = gets
  until !rawline
    input1 << rawline.chomp
    rawline = gets
  end

  rawline = gets
  until !rawline
    input2 << rawline.chomp
    rawline = gets
  end

  p input1
  p "---"
  p input2
end

main()
