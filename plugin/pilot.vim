function! s:run()
ruby << EOF
  require 'thread'
  require 'fileutils'
  require 'timeout'
  require 'socket'

  module Headspace
    class Supervisor
      def initialize
        puts "zomg"
        @server = TCPServer.new(8080)
      end

      def call
        client = @server.accept
        client.puts "Hai"
        client.puts "timezzzzz #{Time.now}"
        client.close
      end
    end

    class Buffer
      def initialize
        @buffer = Vim::Buffer.current
      end

      def call
        lines = (1..3).map { |i| @buffer[i] }
        puts lines.join(' ')
      end
    end
  end

  # @instance ||= Headspace::Supervisor.new
  @instance = Headspace::Supervisor.new
  @instance.call
EOF
endfunction

command! Headspace call s:run()
