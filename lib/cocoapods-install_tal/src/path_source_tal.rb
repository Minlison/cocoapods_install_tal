module Pod
    class PathSourceTal < PathSource
        def fetch(sandbox)
            title = "Fetching podspec for `#{name}` #{description}"
            UI.titled_section(title,  :verbose_prefix => '-> ') do
              podspec = podspec_path
              unless podspec.exist?
                puts "Warning - No podspec found for `#{name}` in " \
                  "`#{declared_path}`"
                  return
              end
              store_podspec(sandbox, podspec, podspec.extname == '.json')
              is_absolute = absolute?(declared_path)
              sandbox.store_local_path(name, podspec, is_absolute)
              sandbox.remove_checkout_source(name)
            end
        end
    end
end