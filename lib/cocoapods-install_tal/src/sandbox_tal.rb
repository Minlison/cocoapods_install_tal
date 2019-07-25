module Pod
    class SandboxTal < Sandbox
        def store_podspec(name, podspec, _external_source = false, json = false)
            file_name = json ? "#{name}.podspec.json" : "#{name}.podspec"
            output_path = specifications_root + file_name
            output_path.dirname.mkpath
            if podspec.is_a?(String)
              output_path.open('w') { |f| f.puts(podspec) }
            else
              unless podspec.exist?
                puts "Warning -- No podspec found for `#{name}` in #{podspec}"
                return
              end
              FileUtils.copy(podspec, output_path)
            end
      
            Dir.chdir(podspec.is_a?(Pathname) ? File.dirname(podspec) : Dir.pwd) do
              spec = Specification.from_file(output_path)
      
              unless spec.name == name
                raise Informative, "The name of the given podspec `#{spec.name}` doesn't match the expected one `#{name}`"
              end
            end
          end
    end
end