Pod::Spec.new do |s|
  s.name             = "Adevinta-Segment-Appboy"
  s.version          = "3.6.1"
  s.summary          = "AdevintaSpain's fork for Braze Integration for Segment's analytics-ios library."

  s.description      = <<-DESC
                       Analytics for iOS provides a single API that lets you
                       integrate with over 100s of tools.

                       This is the Braze integration for the iOS library.
                       DESC

  s.homepage         = "https://github.com/AdevintaSpain/appboy-segment-ios"
  s.license          =  { :type => 'MIT' }
  s.author           = { "Appboy" => "hello@braze.com" }
  s.source           = { :git => "https://github.com/AdevintaSpain/appboy-segment-ios.git", :tag => s.version.to_s }

  s.platform     = :ios, '11.0'
  s.requires_arc = true

  s.dependency 'Analytics'
  s.default_subspec = 'Full-SDK'

  # Skip this architecture to pass Pod validation since we removed the `arm64` simulator ARCH in order to use lipo later
  s.pod_target_xcconfig = {  'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.subspec 'Full-SDK' do |default|
    default.dependency 'Appboy-iOS-SDK', '~>3.31.0'
    default.source_files = 'Pod/Classes/**/*'
  end

  s.subspec 'Core' do |core|
    core.dependency 'Appboy-iOS-SDK/Core', '~>3.31.0'
    core.source_files = 'Pod/Classes/**/*'
  end
  
  s.subspec 'InAppMessage' do |iam|
    iam.dependency 'Appboy-iOS-SDK/InAppMessage', '~>3.31.0'
    iam.source_files = 'Pod/Classes/**/*'
  end
  
  s.subspec 'NewsFeed' do |nf|
    nf.dependency 'Appboy-iOS-SDK/NewsFeed', '~>3.31.0'
    nf.source_files = 'Pod/Classes/**/*'
  end
  
  s.subspec 'ContentCards' do |cc|
    cc.dependency 'Appboy-iOS-SDK/ContentCards', '~>3.31.0'
    cc.source_files = 'Pod/Classes/**/*'
  end

end
