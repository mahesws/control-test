require 'json'
Puppet::Functions.create_function(:'getHostConfig') do

    dispatch :getHostConfig do
        param 'String', :fqdn
    end

    def getHostConfig(fqdn)
        finalHostJsonContents = {}
        hostJsonContents = {}
        json_dir_prefix = '/tmp'
        hostFqdn = fqdn
        hostFqdnDir = "#{json_dir_prefix}/#{hostFqdn}"
        hostFqdnDirJson = "#{hostFqdnDir}/#{hostFqdn}/#{hostFqdn}.json"
        if File.exist?(hostFqdnDirJson)
            hostJsonContents = JSON.parse(File.read("#{hostFqdnDirJson}"))
        end
        finalHostJsonContents.merge!(hostJsonContents)
        finalHostJsonContents
    end
end
