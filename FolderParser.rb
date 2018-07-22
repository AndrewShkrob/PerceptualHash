require_relative "ComparedObjects"

class FolderParser
  
  def self.parse(folder1, folder2)
    
    compared_objects = []
    
    files1 = Dir.entries(folder1).sort.reject { |f| File.directory?(f) }
    files2 = Dir.entries(folder2).sort.reject { |f| File.directory?(f) }
    
    files1.each do |f1|
      filename = f1.split('.')[0]
    
      arr = []
      files2.each do |f2|
        if filename == f2.split('.')[0] then
          arr.push(f2)
        end
      end
    
      if arr.length == 0 then
        STDERR.puts "Error. In directory \"#{folder2}\" couldn't find file with name \"#{filename}\" from the directory \"#{folder1}\""
      end
      
      arr.each do |f2|
        compared_objects.push(create_compared_objects("#{folder1}/#{f1}", "#{folder2}/#{f2}"))
      end
      
    end
    
    compared_objects
  end
  
end