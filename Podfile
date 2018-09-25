platform :ios, '12.0'

target 'RCCodingChallenge' do
  use_frameworks!

  # Pods for RCCodingChallenge
  pod 'RCCodingChallengeFramework', :git => 'https://github.com/ocwang/RCCodingChallengeFramework.git', :branch => 'master'
end

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
