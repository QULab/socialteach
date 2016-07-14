namespace :deploy do
  namespace :assets do

    Rake::Task['deploy:assets:precompile'].clear_actions

    desc 'Precompile assets locally and upload to servers'
    task :precompile do
      on roles(fetch(:assets_roles)) do
        run_locally do
          with rails_env: fetch(:rails_env) do
            execute 'bin/spring stop'
            execute 'bin/rake assets:precompile'
          end
        end

        within release_path do
          with rails_env: fetch(:rails_env) do
            upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
          end
        end

        run_locally { execute 'rm -rf public/assets' }
      end
    end

  end
end

