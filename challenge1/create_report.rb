def read_file(path_infile)
  infile = File.open(path_infile, 'r')
  raw_lines = infile.readlines
  infile.close

  raw_lines.shift # Dump the first line which has identifiers but no data
  raw_lines
end

def read_file_source1(path_infile)
  raw_lines = read_file(path_infile)
  result = []

  raw_lines.each_with_index do |line, idx|
    raw_entry = line.chomp.split(",")
    raw_field1 = raw_entry[1].split("_")
    entry = {}

    entry["id"] = idx
    entry["campaign_id"] = raw_entry[0]
    entry["state"] = raw_field1[0]
    entry["hair_color"] = raw_field1[1]
    entry["age_range"] = raw_field1[2]
    entry["impressions"] = raw_entry[2].to_i

    result << entry
  end

  result
end

def parse
end

def read_file_source2(path_infile)
  raw_lines = read_file(path_infile)
  result = []

  raw_lines.each_with_index do |line, idx|
    raw_entry = line.chomp.split(",")

    # p raw_entry
    p raw_entry[3]
    # p raw_entry[4..-1]
    # raw_entry[4..-1].each do |element|
    #   print element.delete("\"").length.to_s + " | "
    #   p element.delete("\"").delete("[").delete("{").delete(" ")
    #   sleep(5)
    # end
    # p "---"

    # raw_entry = line.chomp.split(",")
    # raw_field1 = raw_entry[1].split("_")
    entry = {}
    #
    entry["id"] = idx
    entry["campaign_id"] = raw_entry[0]
    entry["ad_type"] = raw_entry[1]
    entry["date"] = raw_entry[2]
    entry["spend"] = raw_entry[3]
    # entry["state"] = raw_field1[0]
    # entry["hair_color"] = raw_field1[1]
    # entry["age_range"] = raw_field1[2]
    # entry["impressions"] = raw_entry[2].to_i
    #
    # result << entry
  end

  result
end


def create_report
  # source1 = read_file_source1("source1.csv")

  source2 = read_file_source2("source2.csv")
  # i = 0
  # while i < 5
  #   p source2[i]
  #   i+=1
  # end


end

create_report()

# Some things I've learned from analyzing the dataset in source2:
#
# 1) All campaign ids are a string of length 36
# 2) value of ad_type field is always either "photo" or "video"
# 3) the value of every date field is the same length as the other date fields
# 4) the value in the spend field is variable length: ranges from length 1 to at least 3 digits
