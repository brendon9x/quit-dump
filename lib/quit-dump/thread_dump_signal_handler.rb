# Copied from https://github.com/ph7/xray
#
# Install a signal handler to dump backtraces for all threads
#
# Trigger it with: kill -HUP <pid>
#
thread_dumper = lambda do |thread, stack|
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

trap "HUP" do
  if Kernel.respond_to? :caller_for_all_threads
    STDERR.puts "\n=============== Thread Dump ==============="
    caller_for_all_threads.each { |(thread, stack)| thread_dumper[thread, stack]}
  elsif Thread.respond_to? :list
    STDERR.puts "\n=============== Thread Dump ==============="
    Thread.list.each { |t| thread_dumper[t, t.backtrace] }
  else
    STDERR.puts "=============== Current Thread Backtrace ==============="
    STDERR.puts "Current thread : #{Thread.inspect}"
    STDERR.puts caller.join("\n    \\_ ")
  end
  STDERR.puts "\n=============== Done ===============\n"
end
