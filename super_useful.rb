# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError, TypeError
    nil
  # end
end

# PHASE 3

# Overview
#
# Sometimes when an error is thrown we would like to try the failing operation again (hopefully with different input 😉). This is often the case with user input and text parsing. Let's try to make friendly monster happy by allowing us to retry feeding it a fruit when certain errors are thrown.
#
# Instructions
#
# Friendly monster is really friendly and really likes coffee, so he'd like to give us another try, but only when we give him "coffee".
#
# First, handle the errors being thrown by #reaction in #feed_me_a_fruit.
#
# Note that #reaction throws errors receiving an argument that is not in FRUITS. Next, let's differentiate the errors thrown so our calling function, #feed_me_a_fruit can try to feed friendly monster again, but only when they've given it coffee.
#
# Now that we have different error types being thrown by #reaction we can do a little conditional logic in #feed_me_a_fruit to retry the failing block of code again, but only if it is a coffee-related error.
#


FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  # begin
    if FRUITS.include?(maybe_fruit)

      puts "OMG, thanks so much for the #{maybe_fruit}!"

    else
      raise StandardError
    end
  rescue StandardError
    if maybe_fruit == "coffee"
      # feed_me_a_fruit
      puts "I do like coffee!! Try again"
      maybe_fruit = gets.chomp
      retry
    end
  # end

end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
end

class TooFewYears < StandardError
  def message
    "Thats not enough years to be best friends"
  end
end

class YouDontEvenKnowMyName < StandardError
  def message
    "You don't know my name??!"
  end
end

class MyHobbies < StandardError
  def message
    "You need to know my hobbies for us to be friends"
  end
end

# PHASE 4
class BestFriend
  ALPHABET = ("a".."z").to_a
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

      # puts "You don't know my name??!"
      # name = gets.chomp
    raise MyHobbies if fav_pastime.length <= 1
    raise YouDontEvenKnowMyName if name.length <= 1
    raise TooFewYears if yrs_known <= 5
    rescue StandardError => e
      puts e.message
      if e.is_a?(MyHobbies)
        until fav_pastime.length > 1
          fav_pastime = gets.chomp
        end

      elsif e.is_a?(YouDontEvenKnowMyName)
        name = gets.chomp

      elsif e.is_a?(TooFewYears)
        yrs_known = gets.chomp
      end
      retry
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
