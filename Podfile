# Uncomment the next line to define a global platform for your project
platform :ios, "11.0"
use_frameworks!
inhibit_all_warnings!

target 'CapstoneProject' do
  pod 'MessageKit'
  pod 'DLRadioButton', '~> 1.4'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if target.name == 'MessageKit'
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.2'
              end
          end
      end
  end
end
