require_relative 'classes/eft'

issue = EFT.get_issue
system('clear') # This will clear the console
EFT.tap(issue)