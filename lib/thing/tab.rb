module Thing
  class Tab
     def initialize(log)
       @log = File.new("#{Dir.pwd}/#{log}.csv", "w")
     end

     def add_item(results)
       @log.puts results.join(',')
     end

     def close_out
       @log.close
     end
  end
end