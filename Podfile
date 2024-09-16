platform :ios, '13.0'

target 'staj' do
  use_frameworks!

  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'Firebase/Messaging'
  pod 'Firebase/RemoteConfig'

  pod 'Alamofire'
  pod 'AppRating', '>= 0.0.1'
  pod 'SVProgressHUD'
  pod 'SwiftyStoreKit'
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end