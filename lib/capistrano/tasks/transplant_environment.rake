namespace :deploy do
  desc 'Copies all local environment config files into config'
  task :transplant_environment do
    on release_roles :all do
      source = release_path.join('config', 'cap_environments', fetch(:stage))
      target = release_path.join('config')

      if test "[ -d #{source} ]"
        execute :rsync, '-a', "#{source}/", target
      else
        warn "cap_environment for #{fetch(:stage)} not found!"
      end
    end
  end
end

after 'deploy:updating', 'deploy:transplant_environment'
