require_relative "Utils"
require_relative "Comparator"

class ComparedObjects
  
  def initialize(file1, file2, file1_type, file2_type)
    @file1 = file1
    @file2 = file2
    @file1_type = file1_type
    @file2_type = file2_type
  end
  
  def get_file1()
    @file1
  end
  
  def get_file2()
    @file2
  end
  
  def get_file_type()
    if @file1_type != @file2_type 
      return COLOR_RED + "Different Types" + COLOR_NC
    end
    
    if !["audio", "image", "text", "video"].flatten.include?(@file1_type)
      "byte"
    else
      @file1_type
    end
  end
  
  def get_simularity()
    if @file1_type != @file2_type 
      return COLOR_RED + "Error" + COLOR_NC
    end
    
    case @file1_type
    when "audio"
      (Comparator.compare_audio(@file1, @file2) * 100).round
    when "image"
      (Comparator.compare_image(@file1, @file2) * 100).round
    when "text"
      (Comparator.compare_text(@file1, @file2) * 100).round
    when "video"
      (Comparator.compare_video(@file1, @file2) * 100).round
    else
      (Comparator.compare_byte(@file1, @file2) * 100).round
    end
  end
end

def create_compared_objects(file1, file2)
  comp_object = ComparedObjects.new(file1, file2, get_file_type(file1), get_file_type(file2))
end

def get_file_type(path)
  message = `file --mime -b #{path}`.split('/')[0]
end