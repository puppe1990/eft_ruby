# frozen_string_literal: true

require_relative '../modules/phrases'
require 'debug'

class EFT
  def self.ask_route
    print 'You Want to Tap for a Specific Issue or a custom phrase? (1 or 2) '
    gets.to_i
  end

  def self.ask_feeling
    print 'On a scale from 0 to 10, how do you feel now? '
    gets.to_i
  end

  def self.positive_emotion_or_goal
    print 'Enter a positive emotion or goal: '
    gets.chomp
  end

  def self.issue
    print 'Enter an issue or emotion to focus on: '
    gets.chomp
  end

  def self.tap_points(issue, phrases, final_phrase = nil, is_custom = false)
    Phrases::TAPPING_POINTS.each_with_index do |point, index|
      phrase = if is_custom
                 Phrases::CUSTOM_PHRASES[index]
               else
                 final_phrase || phrases.sample.gsub('[issue]', issue)
               end
      puts "Tap on the \e[32m#{point}\e[0m while focusing on the following issue: '\e[32m#{issue}\e[0m'"
      puts 'Take a deep breath and tap 5-7 times on each point.'
      if point == 'Karate chop'
        3.times { puts "\e[32m#{phrase}\e[0m" }
      else
        puts "\e[32m#{phrase}\e[0m"
      end
      print 'Press enter to continue or type "exit" to end the session: '
      input = gets.chomp
      system('clear') # This will clear the console
      return if input == 'exit'
    end
  end

  def self.tap(issue, phrases = Phrases::DEFAULT_PHRASES, is_custom = false)
    start_time = Time.now # Add this line to store the start time of the session
    feeling = nil
    until feeling == 0
      feeling = ask_feeling
      system('clear') # This will clear the console
      if feeling == 0
        result = positive_emotion_or_goal
        final_phrase = Phrases::FINAL_PHRASES.sample.gsub('[positive emotion or goal]', result)
        tap_points(result, phrases, final_phrase)
        puts "\e[32m#This is the end!\e[0m"
        break
      end
      tap_points(issue, phrases, nil, is_custom)
    end

    elapsed_time = Time.now - start_time # Calculate elapsed time
    elapsed_minutes = (elapsed_time / 60).floor  # Convert elapsed time to minutes
    elapsed_seconds = (elapsed_time % 60).round  # Convert remaining seconds to seconds
    puts "Total time: #{elapsed_minutes}:#{'%02d' % elapsed_seconds}" # Print elapsed time in MM:SS format
  end
  
end

