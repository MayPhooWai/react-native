class Post < ApplicationRecord
    require "csv"
    # function import
    # import post csv
    # @param [<Type>] file <description>
    # @param [<Type>] current_user_id <description>
    # @return [<Type>] <description>
    def self.import(file)
      begin
        CSV.foreach(file.path, headers: true, encoding: "iso-8859-1:utf-8", row_sep: :auto, header_converters: :symbol) do |row|
          Post.create! row.to_hash.merge(created_at: Time.now, updated_at: Time.now)
        end
        return true
      rescue => exception
        return exception
      end
    end
  
    def name
      self.name
    end
  end
