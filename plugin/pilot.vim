function! Headspace()
ruby << EOF
  class Garnet
    def initialize(s)
      @buffer = Vim::Buffer.current
      vimputs(s)
    end

    def vimputs(s)
      @buffer.append(@buffer.count, s)
    end
  end

  gem = Garnet.new("hi alice")
EOF
endfunction

com! Headspace cal Headspace()
