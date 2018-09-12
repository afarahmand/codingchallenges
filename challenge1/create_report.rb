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
    entry = {
      "id": idx,
      "campaign_id": raw_entry[0],
      "state": raw_field1[0],
      "hair_color": raw_field1[1],
      "age_range": raw_field1[2],
      "impressions": raw_entry[2].to_i
    }

    result << entry
  end

  result
end

def process_action(raw_action)
  temp = raw_action.delete("\"[] ").split(",")
  action = {
    "source": temp[0].split(":")[0],
    "value": temp[0].split(":")[1].to_i,
    "action_type": temp[1].split(":")[1]
  }

  action
end

# Parse out each individual action per entry from source2
def process_raw_entry_part2(raw_entry)
  raw_action_string = ""
  actions = []

  beg_idx = 2
  fin_idx = raw_entry.index("}")
  while beg_idx
    raw_action_string = raw_entry[(beg_idx+1)..(fin_idx-1)]
    beg_idx = raw_entry.index("{", fin_idx)
    fin_idx = raw_entry.index("}", beg_idx) if beg_idx
    actions << process_action(raw_action_string)
  end

  actions
end

def read_file_source2(path_infile)
  raw_lines = read_file(path_infile)
  result = []

  raw_lines.each_with_index do |line, idx|
    beg_index_of_part2 = line.index("\"[{")
    raw_entry_part1 = line.chomp[0..(beg_index_of_part2 - 2)].split(",")
    raw_entry_part2 = line.chomp[beg_index_of_part2..(-1)]

    entry = {
      "id": idx,
      "campaign_id": raw_entry_part1[0],
      "ad_type": raw_entry_part1[1],
      "date": raw_entry_part1[2],
      "spend": raw_entry_part1[3].to_i,
      "actions": process_raw_entry_part2(raw_entry_part2)
    }

    result << entry
  end

  result
end


def create_report
  source1 = read_file_source1("source1.csv")
  source2 = read_file_source2("source2.csv")


end

create_report()

# ---
# I intend to make a solve all of the questions using naive solutions in a first pass, then
#  going through one or more additional times to change how source1 and 2 are stored in order
#  to solve the questions in a (potentially) more optimal time.
#
# There are only 10k records in each data file.  If not many
# ---

# Some things I've learned from analyzing the dataset in source2:
#
# 1) All campaign ids are a string of length 36
# 2) value of ad_type field is always either "photo" or "video"
# 3) the value of every date field is the same length as the other date fields
# 4) the value in the spend field is variable length: ranges from length 1 to at least 3 digits
