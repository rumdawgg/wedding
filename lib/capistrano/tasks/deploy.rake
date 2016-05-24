namespace :deploy do
  desc 'Make live with downtime'
  task :promote_downtime do
    roles(:app).each do |server|
      Capistrano::HaproxyHelper.new(self).disable(server)
    end

    run_locally { info '=========== BEGINNING DOWNTIME =========='.bold.red }
    invoke 'rails:migrate'
    invoke 'deploy:rolling_restart'

    roles(:app).each do |server|
      Capistrano::HaproxyHelper.new(self).enable(server)
    end

    run_locally { info '=========== SITE IS LIVE =========='.bold.green }
  end

  task :promote_normal do
    invoke 'deploy:rolling_restart'
  end

  desc 'Restart Passenger workers Zero Downtime'
  task :rolling_restart do
    haproxy = Capistrano::HaproxyHelper.new(self)
    on roles(:app), in: :sequence do |server|
      passenger = Capistrano::PassengerHelper.new(self)

      info "=========== Promoting #{server} ==========".bold.blue
      haproxy.disable(server)
      passenger.graceful(server)
      passenger.wait_for_quick_response(server)
      haproxy.enable(server)
    end
  end
end
