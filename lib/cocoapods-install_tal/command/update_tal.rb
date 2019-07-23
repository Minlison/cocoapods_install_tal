module Pod
    class Command
        class Update_tal < Update
          
            # self.summary = '替代 Cocoapods 原生 install，可以自动解决库中冲突 lib'
      
            # self.description = <<-DESC
            #   替代 Cocoapods 原生 install，可以自动解决库中冲突 lib
            # DESC
      
            def self.options
              [
                ['--no-fix', 'not fix conflict after install before generate project'],
              ].concat(super)
            end
            
            def initialize(argv)
              @no_fix = argv.flag?('no-fix', false)
              super
            end
      
            def installer_tal_for_config
              InstallerTal.new(config.sandbox, config.podfile, config.lockfile, !@no_fix)
            end
            
            def run
                verify_podfile_exists!

                installer = installer_tal_for_config
                installer.repo_update = repo_update?(:default => true)
                if @pods
                  verify_lockfile_exists!
                  verify_pods_are_installed!
                  installer.update = { :pods => @pods }
                else
                  UI.puts 'Update all pods'.yellow
                  installer.update = true
                end
                installer.install!
            end
      
          end
    end
  end
  