require "phash"
require "fuzzystringmatch"

class Comparator
  def self.compare_audio(file1, file2)
    Phash::Audio.new(file1) % Phash::Audio.new(file2)
  end

  def self.compare_byte(file1, file2)
    result = `cmp -b -l #{file1} #{file2}`
    if result.to_str() == ""
      1
    else
      0
    end
  end

  def self.compare_image(file1, file2)
    Phash::Image.new(file1) % Phash::Image.new(file2)
  end

  def self.compare_text(file1, file2)
    text1 = IO.read(file1)
    text2 = IO.read(file2)
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    jarow.getDistance(text1, text2)
  end

  def self.compare_video(file1, file2)
    Phash::Video.new(file1) % Phash::Video.new(file2)
  end
end