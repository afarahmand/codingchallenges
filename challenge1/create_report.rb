def read_file_source1(path_infile)
  result = []
  infile = File.open(path_infile, 'r')
  raw_lines = infile.readlines
  raw_lines.shift # Dump the first line which has identifiers but no data

  raw_lines.each_with_index do |line, idx|
    raw_entry = line.chomp.split(",")
    raw_field1 = raw_entry[1].split("_")
    entry = {}

    entry["campaign_id"] = raw_entry[0]
    entry["state"] = raw_field1[0]
    entry["hair_color"] = raw_field1[1]
    entry["age_range"] = raw_field1[2]
    entry["impressions"] = raw_entry[2].to_i

    # p entry.values
    # sleep(1) if idx > 4
    result << entry
  end

  result
end

# def read_file_source2(path_infile)
#   result = []
#   infile = File.open(path_infile, 'r')
#   result = infile.readlines
#   result
# end

def create_report
  source1 = read_file_source1("source1.csv")
  # source2 = read_file_source2("source2.csv")

  i = 0
  while i < 5
    p source1[i]
    i+=1
  end

  # i = 0
  # while i < 5
  #   p source2[i]
  #   i+=1
  # end


end

create_report()
