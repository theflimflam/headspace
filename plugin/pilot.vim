function! s:run()
ruby << EOF
  require 'thread'
  require 'fileutils'
  require 'timeout'
  require 'socket'

  # VERSION_MAJOR VERSION_MINOR VERSION_BUILD VERSION_PATCHLEVEL VERSION_SHORT
  # VERSION_MEDIUM VERSION_LONG VERSION_LONG_DATE DeletedBufferError DeletedWindowError Buffer Window

  module Headspace
    class Supervisor
      def initialize
        @server = TCPServer.new(8080)
      end

      def call
        client = @server.accept
        client.puts "The time is totally #{Time.now}"
        client.puts "========================================"
        client.puts Buffer.new.call
        client.puts "========================================"
        puts client.gets
        client.close
      end
    end

    class Sender
    end

    class Buffer
      def initialize
        @buffer = Vim::Buffer.current
      end

      def call
        buffer_contents.join(' ')
      end

      private

      def buffer_contents
        buffer_lines.map { |i| @buffer[i] }
      end

      def buffer_lines
        1..last_line_number
      end

      def last_line_number
        @buffer.length
      end
    end
  end

  @instance ||= Headspace::Supervisor.new
  @instance.call
EOF
endfunction

command! Headspace call s:run()
