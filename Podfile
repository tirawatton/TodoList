# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!
install! 'cocoapods', :disable_input_output_paths => true

target 'TodoList' do
  # Pods for TodoList
  pod 'Alamofire', '~> 5.2'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'MBProgressHUD', '~> 1.2.0'
  
end

target 'TodoListTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'TodoListUITests' do
  # Pods for testing
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
    end
  end
end
