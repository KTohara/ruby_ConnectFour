# frozen_string_literal: true

# Monkey-patched String class for colors
class String
  def black
    "\e[2m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[92m#{self}\e[0m"
  end

  def yellow
    "\e[93m#{self}\e[0m"
  end

  def blue
    "\e[94m#{self}\e[0m"
  end

  def cyan
    "\e[36m#{self}\e[0m"
  end

  def gray
    "\e[37m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end
end
