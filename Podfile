# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AbilityToHelp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


 pod "youtube-ios-player-helper", "~> 1.0.4"
 pod 'SDWebImage'
pod 'FMDB'
pod 'Each', '~> 1.2'

#words pod
pod "KRProgressHUD"
pod 'SwiftyStoreKit'
pod 'SDWebImage'
pod 'OneSignal', '>= 3.0.0', '< 4.0'
pod 'NVActivityIndicatorView'
pod 'FirebaseAuth'
#pod 'FirebaseFirestore'
#pod 'Firebase/Database'
#pod 'FirebaseAnalytics'
#pod 'FirebaseDatabase'
#pod 'FirebaseRemoteConfig'
#pod 'FirebaseCrashlytics'
pod 'SwiftConfettiView'
pod 'Google-Mobile-Ads-SDK'
pod 'Alamofire'
pod 'Localize-Swift'
pod 'SwiftyJSON'

  # Pods for KidsLogic

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