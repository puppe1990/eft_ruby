# frozen_string_literal: true

class EFT
  TAPPING_POINTS = [
    'Karate chop',
    'Top of head',
    'Eyebrow',
    'Side of eye',
    'Under eye',
    'Under nose',
    'Chin',
    'Collarbone',
    'Underarm'
  ].freeze

  DEFAULT_PHRASES = [
    'Even though I have this [issue], I deeply and completely accept myself.',
    'I am willing to let go of this [issue].',
    'I choose to release this [issue].',
    'I am free of this [issue].'
  ].freeze

  FINAL_PHRASES = [
    'I am worthy and deserving of [positive emotion or goal].',
    'I am confident and capable of [positive emotion or goal].',
    'I am open to feeling [positive emotion or goal] in place of this [issue].'
  ].freeze

  def self.ask_feeling
    print 'On a scale from 0 to 10, how do you feel now? '
    gets.to_i
  end

  def self.get_positive_emotion_or_goal
    print 'Enter a positive emotion or goal: '
    gets.chomp
  end

  def self.get_issue
    print 'Enter an issue or emotion to focus on: '
    gets.chomp
  end

  def self.tap_points(issue, phrases, final_phrase = nil)
    TAPPING_POINTS.each do |point|
      puts "Tap on the \e[32m#{point}\e[0m while focusing on the following phrase: '\e[32m#{final_phrase || phrases.sample.gsub('[issue]', issue)}\e[0m'"
      puts 'Take a deep breath and tap 5-7 times on each point.'
      phrase = phrases.sample.gsub('[issue]', issue)
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

  def self.tap(issue, phrases = DEFAULT_PHRASES)
    feeling = nil
    until feeling == 0
      feeling = ask_feeling
      if feeling == 0
        positive_emotion_or_goal = get_positive_emotion_or_goal
        final_phrase = FINAL_PHRASES.sample.gsub('[positive emotion or goal]', positive_emotion_or_goal)
        tap_points(issue, phrases, final_phrase)
        puts "\e[32m#This is the end!\e[0m"
        break
      end
      tap_points(issue, phrases)
    end
  end
end

issue = EFT.get_issue
EFT.tap(issue)
