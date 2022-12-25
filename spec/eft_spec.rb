require 'rspec'
require_relative '../eft'

describe EFT do
  describe '.ask_feeling' do
    it 'prompts the user to enter a feeling on a scale from 0 to 10' do
      allow(EFT).to receive(:gets).and_return('5')
      expect { EFT.ask_feeling }.to output("On a scale from 0 to 10, how do you feel now? ").to_stdout
    end

    it 'returns the user input as an integer' do
      allow(EFT).to receive(:gets).and_return('5')
      expect(EFT.ask_feeling).to eq(5)
    end
  end

  describe '.get_positive_emotion_or_goal' do
    it 'prompts the user to enter a positive emotion or goal' do
      allow(EFT).to receive(:gets).and_return('happiness')
      expect { EFT.get_positive_emotion_or_goal }.to output("Enter a positive emotion or goal: ").to_stdout
    end

    it 'returns the user input as a string' do
      allow(EFT).to receive(:gets).and_return('happiness')
      expect(EFT.get_positive_emotion_or_goal).to eq('happiness')
    end
  end

  describe '.get_issue' do
    it 'prompts the user to enter an issue or emotion to focus on' do
      allow(EFT).to receive(:gets).and_return('anxiety')
      expect { EFT.get_issue }.to output("Enter an issue or emotion to focus on: ").to_stdout
    end

    it 'returns the user input as a string' do
      allow(EFT).to receive(:gets).and_return('anxiety')
      expect(EFT.get_issue).to eq('anxiety')
    end
  end

  describe '.tap_points' do
    it 'displays tapping points and phrases to the user' do
      allow(EFT).to receive(:gets).and_return('exit')
      expect { EFT.tap_points('anxiety', EFT::DEFAULT_PHRASES) }.to output(/Tap on the .* while focusing on the following issue: 'anxiety'/).and_output { |output| expect(output.strip).to match(/Tap on the .* while focusing on the following issue: 'anxiety'/) }
    end    

    it 'exits the session if the user types "exit"' do
      allow(EFT).to receive(:gets).and_return('exit')
      expect(EFT.tap_points('anxiety', EFT::DEFAULT_PHRASES)).to be_nil
    end
  end

  describe '.tap' do
    it 'starts a tapping session and prompts the user to enter their feelings' do
      allow(EFT).to receive(:gets).and_return('5', 'exit')
      expect { EFT.tap('anxiety', EFT::DEFAULT_PHRASES) }.to output(/On a scale from 0 to 10, how do you feel now?/).to_stdout
    end

    it 'exits the session if the user feels a 0 on the scale' do
      allow(EFT).to receive(:gets).and_return('0', 'exit')
      expect(EFT.tap('anxiety', EFT::DEFAULT_PHRASES)).to be_nil
    end

    it 'asks the user for a positive emotion or goal if the feeling is less than 10' do
      allow(EFT).to receive(:gets).and_return('5', 'happiness', 'exit')
      expect { EFT.tap('anxiety', EFT::DEFAULT_PHRASES) }.to output(/Enter a positive emotion or goal: /).to_stdout
    end

    it 'taps on the points and displays the phrases to the user' do
      allow(EFT).to receive(:gets).and_return('5', 'happiness', 'exit')
      expect { EFT.tap('anxiety', EFT::DEFAULT_PHRASES) }.to output(/Tap on the .* while focusing on the following issue: 'anxiety'/).to_stdout
    end
  end
end

