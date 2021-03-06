require "rubygems"
require "gtk2"
require "calculadora.rb"

class InterfaceCalculadora
  def initialize
    builder = Gtk::Builder.new
    builder.add_from_file('calculadora.glade')
    builder.connect_signals {|handler| method(handler) }
    builder.get_object("window1").show_all
    @textbuffer = builder.get_object("textbuffer1")
    @buffer = ""
    @calculadora = RpnCalc.new
    @calculadora.pilha = [0.0, 0.0, 0.0]
    print
    Gtk::main
  end

  def on_button_clicked button
    case button.builder_name
    when "b1"
      @buffer.concat '1'
    when "b2"
      @buffer.concat '2'
    when "b3"
      @buffer.concat '3'
    when "b4"
      @buffer.concat '4'
    when "b5"
      @buffer.concat '5'
    when "b6"
      @buffer.concat '6'
    when "b7"
      @buffer.concat '7'
    when "b8"
      @buffer.concat '8'
    when "b9"
      @buffer.concat '9'
    when "b0"
      @buffer.concat '0'
    when "comma"
      @buffer.concat '.'
    when "enter"
      enter
      print
    when "del"
      @buffer.chop!
    when "div"
      if @buffer == ""
        @calculadora.div
        print
      else
        enter
        @calculadora.div
        print
      end
    when "plus"
      if @buffer == ""
        @calculadora.sum
        print
      else
        enter 
        @calculadora.sum
        print
      end
    when "minus"
      if @buffer == ""
        @calculadora.sub
        print
      else
        enter
        @calculadora.sub
        print
      end
    when "times"
      if @buffer == ""
        @calculadora.mul
        print
      else
        enter
        @calculadora.mul
        print
      end
    when "pow"
      if @buffer == ""
        @calculadora.pow
        print
      else
        enter
        @calculadora.pow
        print
      end
    when "plus_minus"
      if @buffer == ""
        @calculadora.plus_minus
        print
      else
        enter
        @calculadora.plus_minus
        print
      end
    when "drop"
      if @calculadora.pilha.length == 3
        @calculadora.pilha.pop
        @calculadora.pilha.insert(0,0.0)
      else
        @calculadora.pilha.pop
      end
      print
    end

    case button.builder_name
    when "b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "b0", "comma", "del"
      print
    end
  end

  def enter
    @calculadora.push @buffer.to_f
    @buffer = ""
  end

  def print
    if @buffer == ""
      new_buffer = "0"
    else
      new_buffer = @buffer
    end
    @textbuffer.text = @calculadora.pilha[-3..-1].join("\n")+"\n"+new_buffer
  end

  def destroy
    puts "Mandaram sair..."
    Gtk.main_quit
  end
end

interface = InterfaceCalculadora.new
