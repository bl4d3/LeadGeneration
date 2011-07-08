namespace :rails_tiny_mce do
  desc 'Install the rails_tiny_mce plugin'
  task :install do
    puts "** Installing rails_tiny_mce plugin ..."           

    source = File.join(Rails.root, '/vendor/plugins/rails_tiny_mce/assets/.')
    dest = Rails.root
    FileUtils.cp_r source, dest
         
    puts "** Successfully installed rails_tiny_mce plugin"
  end
  
  desc 'Install the rails_tiny_mce dependent plugins'
  task :plugins do
    puts "** Installing rails_tiny_mce dependent plugins ..."           

    source = File.join(Rails.root, '/vendor/plugins/rails_tiny_mce/plugins/.')
    dest = File.join(Rails.root, '/vendor/plugins/')
    FileUtils.cp_r source, dest
         
    puts "** Successfully installed rails_tiny_mce dependent plugins"
  end
end
