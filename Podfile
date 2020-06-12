target 'Debugger' do
  use_frameworks!
  pod 'SwiftSocket'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['SwiftSocket'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5'
      end
    end
  end
end
