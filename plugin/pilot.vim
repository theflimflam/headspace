function! Headspace()
ruby << EOF
  class Garnet
    def initialize(s)
      @buffer = Vim::Buffer.current
    end

    def call
      @buffer.delete(2)
      @buffer.append(2, "The stuff")
    end
  end

  gem = Garnet.new("hi alice").call
EOF
endfunction

com! Headspace cal Headspace()
