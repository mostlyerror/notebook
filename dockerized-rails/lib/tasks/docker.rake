namespace :docker do
  desc 'run bash within the docker container'
  task :shell do
    sh('docker', 'run', '--rm', '--interactive', '--tty', '--publish', '80:80', '--volume', [source_path, container_source_path].join(':'), image_name, '/bin/bash')
  end
end
