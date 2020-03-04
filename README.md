#  Highest Number Pairing Problem
This program solves a simple math problem...

## Problem
Find two numbers that add up to the given number (by default is 8), such that the product multiplied by the difference produces the largest possible value.

## To Build
From the command line, enter to build:

`$ swift build`

## To Run

From the command line, enter to run:

`$ swift run`

or

`$ swift run HighestNumberPairing`

You will get a prompt that allows you to enter the number to use. The default is 8, if nothing is entered.

Optionally, you can add the number as a second argument:

`$ swift run HighestNumberPairing 16`

This runs the program with 16 as the number to use.

By default, the program displays only the best result. To also display 10 other top results (sorted high to low). You can specify the `--other-results` or `-o` to show those results.

`$ swift run HighestNumberPairing --other-results 8`

or

`$ swift run HighestNumberPairing -o 8`

To get help, use `--help`:

`$ swift run HighestNumberPairing --help`

## To Test

From the command line, enter to run all unit tests:

`$ swift test`

Tests can also be run from within Xcode.


## New
- Adds the new Swift [ArgumentParser](https://github.com/apple/swift-argument-parser) package.
- New recursive method to find more accurate answer
- New ability to take user input from command line or input prompt
- Collecting and displaying other results is now optional
- Added unit tests
- Revised module structure for better command line testability
- Updated syntax for Swift 5.1
- Changed `NumberPairingProblem` to a structure


## To Do
- More unit testing.
- Improve number formatting for printout (low priority)
