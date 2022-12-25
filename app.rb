require_relative 'classes/eft'

question = EFT.ask_route
system('clear')

case question
when 1
  issue = EFT.issue
  system('clear')
  EFT.tap(issue)
when 2
  CUSTOM_PHRASES = ['Even though I struggle with financial abundance, I deeply and completely accept myself.',
                    'I have a hard time believing I deserve financial abundance.',
                    "I feel like I'm not worthy of abundance.",
                    "I don't know how to attract abundance.",
                    "I'm scared that I'll never have enough money.",
                    "I'm always worried about money.",
                    "I don't trust that I can have abundance.",
                    "I don't believe I deserve abundance.",
                    "I'm worried that I'll never be able to afford the things I want.",
                    "I'm always struggling to make ends meet."].freeze
  system('clear')
  EFT.tap('money issues', CUSTOM_PHRASES, true)
else
  puts 'Invalid option'
end
