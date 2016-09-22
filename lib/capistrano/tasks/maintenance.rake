namespace :maintenance do
  desc 'Get the maintenance page from www.patientslikeme.com/maintenance'
  task :prefetch_page do
    msg = fetch :deploy_msg, 'The site is down for a few minutes of maintenance'

    on primary(:web) do
      header = "--header 'Host: #{fetch :maintenance_fetch_host_header}'"
      target = fetch :maintenance_fetch_url
      output = '/tmp/maintenance.html'

      execute :curl, "-L -k #{header} #{target} -o #{output}"
      execute :sed, "-i 's/DEPLOY_MSG/#{msg}/g' #{output}"
      download! output, output
    end

    on roles(:static) do
      upload! '/tmp/maintenance.html', "#{current_path}/public"
    end
  end
end

namespace :load do
  task :defaults do
    set :maintenance_fetch_host_header, proc { 'www.patientslikeme.com' }
    set :maintenance_fetch_url, proc { 'http://127.0.0.1/maintenance' }
  end
end

after 'deploy:promoted', 'maintenance:prefetch_page'
