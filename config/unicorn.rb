worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    p 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    p 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end
