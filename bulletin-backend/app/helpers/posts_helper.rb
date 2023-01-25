module PostsHelper
  require "csv"
  def self.check_header(header, csv_file)
    input_header = CSV.open(csv_file, "r", encoding: "iso-8859-1:utf-8") { |csv| csv.first }
    error = ""
    if input_header.size != header.size
      error = Messages::WRONG_HEADER
    else
      (0..input_header.size - 1).each do |col_name|
        if (input_header[col_name] == nil)
          error = Messages::WRONG_COLUMN
        end
      end
    end
    return error
  end
end
  