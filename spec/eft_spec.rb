require 'rspec'
require_relative '../eft'

describe EFT do
  describe '.tap' do
    it 'outputs instructions for each tapping point' do
      expect { EFT.tap('anxiety') }.to output(/Tap on the/).to_stdout
    end

    it 'outputs a phrase to repeat while tapping' do
      expect { EFT.tap('anxiety') }.to output(/Even though I have this anxiety, I deeply and completely accept myself./).to_stdout
    end

    it 'outputs the final phrases after the user reports a feeling level of 0' do
      allow(EFT).to receive(:gets).and_return('10', '0')
      expect { EFT.tap('anxiety') }.to output(/I am worthy and deserving of/).to_stdout
    end

    it 'exits the loop if the user types "exit"' do
      allow(EFT).to receive(:gets).and_return('10', 'exit')
      expect { EFT.tap('anxiety') }.not_to output(/I am worthy and deserving of/).to_stdout
    end

    it 'uses the default phrases if no phrases are provided' do
      allow(EFT).to receive(:gets).and_return('10', '0')
      expect { EFT.tap('anxiety') }.to output(/Even though I have this anxiety, I deeply and completely accept myself./).to_stdout
    end

    it 'uses the provided phrases if given' do
      custom_phrases = ['Custom phrase 1', 'Custom phrase 2']
      allow(EFT).to receive(:gets).and_return('10', '0')
      expect { EFT.tap('anxiety', custom_phrases) }.to output(/Custom phrase/).to_stdout
    end
  end
end
