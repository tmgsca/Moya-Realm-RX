platform :ios, '9.0'

inhibit_all_warnings!

target 'MoyaExample' do
  use_frameworks!
  pod 'RxCocoa', '~> 3.0'
  pod 'RxSwift', '~> 3.0'
  pod 'Moya-ModelMapper/RxSwift', '~> 4.1.0'
  pod 'RxOptional'
  pod 'RealmSwift'
  pod 'RxRealm'
  pod 'RxRealmDataSources'
  pod 'RxDataSources', '~> 1.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
              config.build_settings['ENABLE_TESTABILITY'] = 'YES'
              config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
