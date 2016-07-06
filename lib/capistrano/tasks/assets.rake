Rake::Task["deploy:assets:precompile"].clear_actions
namespace :deploy do
  namespace :assets do
    task :precompile do
      puts "##### No precompile #####"
      puts "If you would like to compile assets for a release, please run 'bundle exec rake assets:precompile'"
      puts "#########################"
    end
  end
end
