require 'rspec'
require_relative '../eft'

describe EFT do
  describe '.tap' do

    xit 'outputs a phrase to repeat while tapping' do
      # Stub the first call to gets with a feeling level of 10
      allow(EFT).to receive(:gets).and_return('10')
      # Stub the second call to gets with a feeling level of 0
      allow(EFT).to receive(:gets).and_return('0')
      # Stub all subsequent calls to gets with an empty string
      allow(EFT).to receive(:gets).and_return('')
      expect { EFT.tap('anxiety') }.to output(/Even though I have this anxiety, I deeply and completely accept myself./).to_stdout
    end    

    it 'outputs instructions for each tapping point' do
      allow(EFT).to receive(:gets).and_return('10', '0')
      expect { EFT.tap('anxiety') }.to output(/Tap on the/).to_stdout
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
