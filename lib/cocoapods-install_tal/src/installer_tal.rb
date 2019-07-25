module Pod
  class InstallerTal < Installer
    def initialize(sandbox, podfile, lockfile = nil, auto_fix_conflict = true)
      @sandbox  = sandbox
      @podfile  = podfile
      @lockfile = lockfile
      @auto_fix_conflict = auto_fix_conflict

      @use_default_plugins = true
      @has_dependencies = true
    end

    def install!
        prepare
        resolve_dependencies
        download_dependencies
        validate_targets_remove_confilict
        generate_pods_project
        if installation_options.integrate_targets?
          integrate_user_project
        else
          UI.section 'Skipping User Project Integration'
        end
        perform_post_install_actions
    end

    def create_pod_installer(pod_name)
      specs_by_platform = specs_for_pod(pod_name)

      if specs_by_platform.empty?
        requiring_targets = pod_targets.select { |pt| pt.recursive_dependent_targets.any? { |dt| dt.pod_name == pod_name } }
        message = "Could not install '#{pod_name}' pod"
        message += ", dependended upon by #{requiring_targets.to_sentence}" unless requiring_targets.empty?
        message += '. There is either no platform to build for, or no target to build.'
        raise StandardError, message
      end

      pod_installer = PodSourceInstaller.new(sandbox, specs_by_platform, :can_cache => installation_options.clean?)
      pod_installers << pod_installer
      pod_installer
    end
    
    def validate_targets_remove_confilict
        validator = Xcode::TargetValidatorTal.new(aggregate_targets, pod_targets, @auto_fix_conflict)
        validator.validate!
    end
end
end