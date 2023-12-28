# frozen_string_literal: true

require "optparse"

require "oxo/version"
require "oxo/board"
require "oxo/computer"
require "oxo/human"

# == Name
#
# oxo - a command line Tic-tac-toe game
#
# == See also
#
# Use <tt>oxo --help</tt> to display a brief help message.
#
# The full documentation for +oxo+ is available on the
# project home page.
#
# == Author
#
# Copyright (C) 2016-2022 Marcus Stollsteimer
#
# License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
#
module OXO

  PROGNAME  = "oxo"

  COPYRIGHT = <<~CONTENT
    Copyright (C) 2016-2022 Marcus Stollsteimer.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.
  CONTENT


  # Parser for the command line options.
  # The class method parse! does the job.
  class Optionparser

    # Parses the command line options from +argv+.
    # (+argv+ is cleared).
    # Might print out help or version information.
    #
    # +argv+ - array with the command line options
    #
    # Returns a hash containing the option parameters.
    def self.parse!(argv)
      options = {
        delay: 0
      }

      opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: #{PROGNAME} [options]"
        opt.separator <<~CONTENT

          oxo is a command line Tic-tac-toe game.

          Options:
        CONTENT

        # process --version and --help first,
        # exit successfully (GNU Coding Standards)
        opt.on_tail("-h", "--help", "Print a brief help message and exit.") do
          puts opt_parser
          puts "\nReport bugs on the #{PROGNAME} home page: <#{HOMEPAGE}>"
          exit
        end

        opt.on_tail("-v", "--version",
                    "Print a brief version information and exit.") do
          puts "#{PROGNAME} #{VERSION}"
          puts COPYRIGHT
          exit
        end

        opt.on("-d", "--delay SECONDS", Float,
               "Set delay time for oxo's moves.") do |d|
          options[:delay] = d
        end

        opt.separator ""
      end
      opt_parser.parse!(argv)

      # nothing should be left in argv
      raise(ArgumentError, "wrong number of arguments")  unless argv.empty?

      options
    end
  end

  # The Application class.
  class Application

    ERRORCODE = { general: 1, usage: 2 }.freeze

    def initialize
      begin
        options = Optionparser.parse!(ARGV)
      rescue StandardError => e
        usage_fail(e.message)
      end

      @delay = options[:delay]
    end

    def run
      board = Board.new

      case beginning_side
      when :quit
        return
      when :human
        players = [Human.new(:X), Computer.new(:O, delay: @delay)]
        puts board
      when :computer
        players = [Computer.new(:X, delay: @delay), Human.new(:O)]
      end

      game_over = false

      until game_over
        player = players.first
        move = player.make_move(board)

        break  if move == :quit

        board.place(player.color, move[0], move[1])

        puts board
        puts "Move of #{player.name} was: #{(move[0] - 1) * 3 + move[1]}"

        if board.win?(player.color)
          puts "#{player.name} wins!"
          game_over = true
        elsif board.full?
          puts "It's a draw."
          game_over = true
        end

        players.rotate!
      end
    end

    private

    def beginning_side
      choices = {
        "1" => :human, "" => :human,
        "2" => :computer,
        "0" => :quit, "q" => :quit
      }

      answer = nil
      until choices.keys.include?(answer)
        print "Beginning side (1=Human, 2=Computer, 0/q=quit)? "
        answer = gets.chomp
      end

      choices[answer]
    end

    # Prints an error message and exits.
    def general_fail(message)
      warn "#{PROGNAME}: #{message}"
      exit ERRORCODE[:general]
    end

    # Prints an error message and a short help information, then exits.
    def usage_fail(message)
      warn "#{PROGNAME}: #{message}"
      warn "Use `#{PROGNAME} --help' for valid options."
      exit ERRORCODE[:usage]
    end
  end
end
