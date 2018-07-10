require 'json'
Puppet::Functions.create_function(:'gethostconfig') do

    dispatch :gethostconfig do
        param 'String', :fqdn
    end

    def gethostconfig(fqdn)
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
