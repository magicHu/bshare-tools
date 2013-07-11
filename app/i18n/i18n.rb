# -*- encoding : utf-8 -*-
require 'active_support/all'
require 'set'
require 'pry'

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
  #"/home/magic/git/bshare/bshare_button/src/main/java" => "button_java.properties", 
  #{}"/home/magic/git/bshare/bshare_button/src/main/webapp/jsp" => ["/home/magic/git/bshare/bshare_button/src/main/resources/button_jsp.properties.native", "/home/magic/git/bshare/bshare_button/src/main/resources/MessageResources_zh.properties.native"]
  #"/home/magic/git/bshare/bshare_points/src/main/java" => "points_java.properties",
  #{}"/home/magic/git/bshare/bshare_points/src/main/webapp/jsp" => "points_jsp.properties"
  #{}"/home/magic/git/bshare/bshare_parent/static_root/b" => "button_js.properties"
  "/home/magic/git/bshare/bshare_website/src/main/webapp" => "/home/magic/git/bshare/bshare_website/src/main/resources/MessageResources_zh.properties.native"
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

def read_message_files(message_files)
  messages = {}

  if message_files.respond_to?("each")
    message_files.each do | message_file |
      messages.merge! read_message_file(message_file)
    end
  else
    messages = read_message_file(message_files)
  end
  messages
end

def read_message_file(message_file) 
  messages = {}
  File.open(message_file, "r:UTF-8").each do |line|
    unless line.start_with?('#')
      key, value = line.split('=')
      messages[value.chomp] = key.chomp unless key.blank?
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

      line_temp = nil
      line.scan(@CHINESE_PATTERN).each do |chinese|
          if file_name.end_with? 'main.jsp'
          #  binding.pry
          end

          unless messages[chinese].blank?
            #binding.pry
            is_replace = true

            if file_name.end_with?('.jsp')
              line.sub!(/#{chinese}/, %Q{<s:text name='#{messages[chinese]}'/>})
            elsif file_name.end_with?('.java')
              line.gsub!(/#{chinese}/, %Q{getText("#{messages[chinese]}")})
            end

            puts "#{messages[chinese]}=#{chinese}"
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
  @files.each do |dir, message_files|
    messages = read_message_files(message_files)
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
replace_projects_chinease
