require "phash"
require 'levenshtein'

class Comparator
  
  def self.compare_audio(file1, file2)
    Phash::Audio.new(file1) % Phash::Audio.new(file2)
  end
  
  def self.compare_byte(file1, file2)
    0
  end
  
  def self.compare_image(file1, file2)
    Phash::Image.new(file1) % Phash::Image.new(file2)
  end
  
  def self.compare_text(file1, file2)
    text1 = IO.read(file1)
    text2 = IO.read(file2)
    Levenshtein.distance(text1, text2)
  end
  
  def self.compare_video(file1, file2)
    Phash::Video.new(file1) % Phash::Video.new(file2)
  end
end