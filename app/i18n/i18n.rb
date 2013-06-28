# -*- encoding : utf-8 -*-
require 'active_support/all'
require 'set'

# chinese pattern
@CHINESE_PATTERN = /\p{Han}+/u
# comments pattern
@COMMENTS_PATTERN = /(\/\/|\*)/

def get_file(project_dir)
  Dir.glob(project_dir + '/**/*') do |file|
    if File.file?(file)
      yield(file)
    end
  end
end

def select_chinease(file_name, result_output_file)
  File.open(result_output_file, 'a') do |result|
    result.puts "# #{file_name}"
    File.open(file_name).each do |line| 
      unless line =~ @COMMENTS_PATTERN
        line.scan(@CHINESE_PATTERN).each do |item|
          unless @CHINESE_CACHE.include? item
            result.puts "=#{item}"
            @CHINESE_CACHE.add item
          end
        end
      end
    end
  end
end

@files = {
  "/home/magic/git/bshare/bshare_button/src/main/java" => "button_java.properties", 
  "/home/magic/git/bshare/bshare_button/src/main/webapp/jsp" => "button_jsp.properties",
  "/home/magic/git/bshare/bshare_points/src/main/java" => "points_java.properties",
  "/home/magic/git/bshare/bshare_points/src/main/webapp/jsp" => "points_jsp.properties"
}

def extrac_projects_chinease
  @files.each do |dir, message_file|
    File.delete(message_file) if File.exist? message_file
    @CHINESE_CACHE = Set.new

    get_file(dir) do |file|
      select_chinease(file, message_file)
    end
  end
end

def read_message_file(message_file)
  messages = {}
  File.open(message_file).each do |line|
    unless line.start_with?('#')
      key, value = line.split('=')
      messages[value.chomp] = key.chomp
    end
  end
  messages
end


def replace_chinease(file_name, messages)
  translate_result = ""
  is_replace = false

  new_file_name = "#{file_name}.new"
  File.delete(new_file_name) if File.exist?(new_file_name)

  File.open(new_file_name, 'w') do |new_file|
    File.open(file_name).each do |line| 
      unless line =~ @COMMENTS_PATTERN
      line.scan(@CHINESE_PATTERN).each do |chinese|
          unless messages[chinese].blank?
            is_replace = true

            if file_name.end_with?('.jsp')
              line.gsub!(/#{chinese}/, %Q{<s:text name='#{messages[chinese]}'/>})
            elsif file_name.end_with?('.java')
              line.gsub!(/#{chinese}/, %Q{getText("#{messages[chinese]}")})
            end

          end
        end
      end

      new_file.puts line
    end
  end

  if is_replace
    File.delete(file_name)
    File.rename(new_file_name, file_name)
  else
    File.delete(new_file_name)
  end
end


def replace_projects_chinease
  @files.each do |dir, message_file|
    messages = read_message_file(message_file)
    get_file(dir) do |file|
      if file.end_with?(".new")
        File.delete(file)
      else
        replace_chinease(file, messages)
      end
    end
  end
end

#extrac_projects_chinease
#replace_projects_chinease
