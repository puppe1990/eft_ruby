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
  ]

  DEFAULT_PHRASES = [
    'Even though I have this [issue], I deeply and completely accept myself.',
    'I am willing to let go of this [issue].',
    'I choose to release this [issue].',
    'I am free of this [issue].'
  ]

  FINAL_PHRASES = [
    'I am worthy and deserving of [positive outcome or goal].',
    'I am confident and capable of [positive outcome or goal].',
    'I am open to feeling [positive emotion] in place of this [issue].'
  ]

  def self.tap(issue, phrases = DEFAULT_PHRASES)
    feeling = nil
    until feeling == 0
      print 'On a scale from 0 to 10, how do you feel now? '
      feeling = gets.to_i
      break if feeling == 0

      TAPPING_POINTS.each do |point|
        puts "Tap on the \e[32m#{point}\e[0m while focusing on the issue: '\e[32m#{issue}\e[0m'"
        puts 'Take a deep breath and tap 5-7 times on each point.'
        puts 'As you tap, repeat one of the following phrases to yourself:'
        phrase = phrases.sample.gsub('[issue]', issue)
        if point == 'Karate chop'
          3.times { puts "\e[32m#{phrase}\e[0m" }
        else
          puts "\e[32m#{phrase}\e[0m"
        end

        print 'Press enter to continue or type "exit" to end the session: '
        input = gets.chomp
        system('clear')  # This will clear the console
        break if input == 'exit'
      end
    end
  end
end

print 'Enter an issue or emotion to focus on: '
issue = gets.chomp

EFT.tap(issue)
