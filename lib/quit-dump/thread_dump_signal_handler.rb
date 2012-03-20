# Copied from https://github.com/ph7/xray
#
# Install a signal handler to dump backtraces for all threads
#
# Trigger it with: kill -QUIT <pid>
#
trap "INT" do
  if Kernel.respond_to? :caller_for_all_threads
    STDERR.puts "\n=============== Thread Dump ==============="
    caller_for_all_threads.each_pair do |thread, stack|
      thread_description = thread.inspect
      thread_description << " [main]" if thread == Thread.main
      thread_description << " [current]" if thread == Thread.current
      thread_description << " alive=#{thread.alive?}"
      thread_description << " priority=#{thread.priority}"
      thread_separator = "-" * 78

      full_description = "\n#{thread_separator}\n"
      full_description << thread_description
      full_description << "\n#{thread_separator}\n"
      full_description << "    #{stack.join("\n      \\_ ")}\n"

      # Single puts to avoid interleaved output
      STDERR.puts full_description
    end
  else
    STDERR.puts "=============== Current Thread Backtrace ==============="
    STDERR.puts "Current thread : #{Thread.inspect}"
    STDERR.puts caller.join("\n    \\_ ")
  end
  STDERR.puts "\n=============== Done ===============\n"
end
