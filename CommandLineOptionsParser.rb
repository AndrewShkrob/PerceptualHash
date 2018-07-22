require 'optparse'
require 'ostruct'

class CommandLineOptionsParser
  
  DEFAULT_AUDIO_THRESHOLD_VALUE = 0.3
  DEFAULT_IMAGE_THRESHOLD_VALUE = 0.5
  DEFAULT_TEXT_THRESHOLD_VALUE = 0.5
  DEFAULT_VIDEO_THRESHOLD_VALUE = 0.5
  
  def self.parse(args)
    options = OpenStruct.new
    options.audio = DEFAULT_AUDIO_THRESHOLD_VALUE
    options.image = DEFAULT_IMAGE_THRESHOLD_VALUE
    options.text  = DEFAULT_TEXT_THRESHOLD_VALUE
    options.video = DEFAULT_VIDEO_THRESHOLD_VALUE
  
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: FileComparison.rb path_to_folder1 path_to_folder2 [options]"
    
      opts.separator ""
      opts.separator "Specific options:"
      
      opts.on("-a", "--audio THRESHOLD", Float, "Set audio threshold") do |audio|
        options.audio = audio
      end
      opts.on("-i", "--image THRESHOLD", Float, "Set image threshold") do |image|
        options.image = image
      end
      opts.on("-t", "--text  THRESHOLD", Float, "Set text threshold") do |text|
        options.text = text
      end
      opts.on("-v", "--video THRESHOLD", Float, "Set video threshold") do |video|
        options.video = video
      end
      
      opts.separator ""
      opts.separator "Common options:"
      
      opts.on_tail("-d", "--defaults", "Show default threshold values") do
        puts "Audio Threshold = #{DEFAULT_AUDIO_THRESHOLD_VALUE}"
        puts "Image Threshold = #{DEFAULT_IMAGE_THRESHOLD_VALUE}"
        puts "Text  Threshold = #{DEFAULT_TEXT_THRESHOLD_VALUE}"
        puts "Video Threshold = #{DEFAULT_VIDEO_THRESHOLD_VALUE}"
        exit
      end
      
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end
    
    begin
      opt_parser.parse!(args)
    rescue OptionParser::InvalidOption => invalid_option_ex
      STDERR.puts "Invalid option. Please, use --help flag to see documentation."
      exit -1
    rescue OptionParser::InvalidArgument => invalid_argument_ex
      STDERR.puts "Invalid argument. Please, use --help flag to see documentation."
      exit -1
    rescue OptionParser::MissingArgument => missing_argument_ex
      STDERR.puts "Missing argument. Please, use --help flag to see documentation."
      exit -1
    end
  
    if args.length < 2 || !check_if_path_is_derictory(args[0]) || !check_if_path_is_derictory(args[1])
      puts opt_parser
      exit
    end
  
    options.folder1 = args[0]
    options.folder2 = args[1]
      
    options
  end # parse()
  
  def self.check_if_path_is_derictory(path)
    File.directory?(path)
  end

end