
module WinkerAI
  
  # ON_OFF = {on: /on/, off: /off/}
  # UP_DOWN = {down: /down/, up: /up/}
  # BRIGHTNESS = {percent: /\d{1,3}( percent){0,1}/}+UP_DOWN
  #
  # AIGROUPS = {
  #   name: "Lights",
  #   triggers: [
  #     {
  #       regex: /(dim|raise|lower).*lights{0,1}/,
  #       methods: [:brightness],
  #       values: BRIGHTNESS_VALUES
  #     },
  #     {
  #       regex: /turn.*lights{0,1}/,
  #       methods: [:on, :off, :brightness]
  #       values: UP_DOWN+ON_OFF
  #     },
  #     {
  #       regex: /shut.*lights{0,1}/
  #     }
  #   ]
  # }
  
  LIGHT_TRIGGERS = %w(dim raise lower shut turn)
  EGG_TRIGGERS = %w(eggs)
  
  NUMBERS_MODIFIER = {
    "twenty" => 20,
    "thirty" => 30,
    "fourty" => 40,
    "fifty" => 50,
    "sixty" => 60,
    "seventy" => 70,
    "eighty" => 80,
    "ninety" => 90
  }
  
  NUMBERS_MATCH = {
    "zero" => 0,
    "half" => 50,
    "ten" => 10,
    "eleven" => 11,
    "twelve" => 12,
    "thirteen" => 13,
    "fourteen" => 14,
    "fifteen" => 15,
    "sixteen" => 16,
    "seventeen" => 17,
    "eighteen" => 18,
    "nineteen" => 19,
    "one hundred" => 100
  }
  
  NUMBERS_ADD = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }
  
  LIGHT_TYPES = %w(light_bulb)
  EGG_TYPES = %w(eggtray)
  
  def self.check_for_trigger(string)
    case string
    when /(#{LIGHT_TRIGGERS.join("|")}).*lights{0,1}/
      puts "handling lights"
      handle_lights(string)
    when /(#{EGG_TRIGGERS.join("|")})/
      puts "handling eggs"
      handle_eggs(string)
    else
      #do nothing
    end
  end
  
  def self.handle_eggs(string)
    `osascript -e "set Volume 5"`
    case string
    when /eggs.*(going bad|close|soon)/
      `say 'There are #{eggs.map(&:eggs_warning).flatten.count} eggs that are about to go bad.'`
    when /eggs.*are (bad|past|expired)/
      `say 'There are #{eggs.map(&:eggs_warning).flatten.count} eggs that are past the expiration date.'`
    when /how many.*eggs/
      `say 'There are #{eggs.sum(&:count)} eggs left.'`
    when /eggs.*expire/
      if days = eggs.map(&:days_left).sort.first
        `say 'There are #{days} days left until your first egg expires.'`
      else
        `say 'There are no eggs left.'`
      end
    else
      #do nothing didn't find the proper egg question
    end
  end
  
  def self.handle_lights(string)
    number = find_number(string)
    devices = $wink_groups.select{|d| string.match(/#{d.name}/i)}
    devices = lights.select{|d| string.match(/#{d.name}/i)} if devices.empty?
    case 
    when number && string.match(/(#{LIGHT_TRIGGERS.join("|")})/) && !devices.empty?
      puts "case 1"
      devices.each do |d|
        puts "brightness: #{d.name} #{number}"
        d.brightness = number/100.0
      end
    when !number && (_match1 = string.match(/(#{LIGHT_TRIGGERS.join("|")})/)[1]) && !devices.empty?
      puts "case 2"
      case 
      when _match1 == "raise"
        puts "case 3"
        devices.each do |d|
          d.brightness = [d.brightness+0.25,1].min
        end
      when _match1 == "lower"
        puts "case 4"
        devices.each do |d|
          d.brightness = [d.brightness-0.25,0].max
        end
      when _match2 = string.match(/turn.*\s(on|off)/)[1]
        puts "case 5"
        devices.each do |d|
          case _match2 
          when "on"
            d.on
          when "off"
            d.off
          end
        end
      end
    when number && string.match(/(#{LIGHT_TRIGGERS.join("|")})/) && devices.empty?
      puts "case 6"
      lights.each do |d|
        d.brightness = number/100.0
      end
    when !number && (_match1 = string.match(/(#{LIGHT_TRIGGERS.join("|")})/)[1]) && devices.empty?
      puts "case 7"
      case 
      when _match1 == "raise"
        puts "case 8"
        lights.each do |d|
          d.brightness = [d.brightness+0.25,1].min
        end
      when _match1 == "lower"
        puts "case 9"
        lights.each do |d|
          d.brightness = [d.brightness-0.25,0].max
        end
      when _match2 = string.match(/turn.*\s(on|off)/)[1]
        puts "case 10"
        lights.each do |d|
          case _match2 
          when "on"
            d.on
          when "off"
            d.off
          end
            
        end
      end
    end
  end
  
  def self.find_number(string)
    found_number = case string
    when /(#{NUMBERS_MODIFIER.keys.join("|")}) (#{NUMBERS_ADD.keys.join("|")})/
      NUMBERS_MODIFIER[$1]+NUMBERS_ADD[$2]
    when /(#{NUMBERS_MODIFIER.keys.join("|")})/
      NUMBERS_MODIFIER[$1]
    when /(#{NUMBERS_MATCH.keys.join("|")})/
      NUMBERS_MATCH[$1]
    when /(#{NUMBERS_ADD.keys.join("|")})/
      NUMBERS_ADD[$1]
    else
      nil
    end
    return found_number
  end
  
  def self.lights
    $wink_devices.select{|d| LIGHT_TYPES.include?(d.type)}
  end
  
  def self.eggs
    $wink_devices.select{|d| EGG_TYPES.include?(d.type)}
  end
  
  def self.setup
    Winker.configure do |wink|
      wink.client_id      = ENV['WINK_CLIENT_ID']
      wink.client_secret  = ENV['WINK_CLIENT_SECRET']
      wink.access_token   = ENV['WINK_ACCESS_TOKEN']
      wink.refresh_token  = ENV['WINK_REFRESH_TOKEN']
      wink.username       = ENV['WINK_USERNAME']
      wink.password       = ENV['WINK_PASSWORD']
      wink.endpoint       = ENV['WINK_ENDPOINT']
    end
    set_devices
  end
  
  def self.set_devices
    begin
      $wink_devices ||= Winker.devices
      $wink_groups ||= Winker.groups
    rescue
      Winker.authorize
      retry
    end
  end
end
