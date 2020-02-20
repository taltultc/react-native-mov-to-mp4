require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']
  s.license      = { :type => 'BSD' }
  s.homepage     = 'https://github.com/taltultc/react-native-mov-to-mp4'
  s.authors      = package['author']
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/taltultc/react-native-mov-to-mp4", :tag => "v#{s.version}" }
  s.source_files  = "**/*.{h,m}"

  s.dependency 'React'
end

