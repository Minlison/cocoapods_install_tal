module Pod
    class ConfigTal < Config
        def sandbox
            @sandbox ||= SandboxTal.new(sandbox_root)
        end
        def self.instance
            @instance ||= new
        end

        class << self
            attr_writer :instance
        end

        module Mixin
            def config
                ConfigTal.instance
            end
        end
    end
end