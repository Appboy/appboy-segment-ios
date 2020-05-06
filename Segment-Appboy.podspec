Pod::Spec.new do |s|
  s.name             = "Segment-Appboy"
  s.version          = "3.0.0"
  s.summary          = "Braze Integration for Segment's analytics-ios library."

  s.description      = <<-DESC
                       Analytics for iOS provides a single API that lets you
                       integrate with over 100s of tools.

                       This is the Braze integration for the iOS library.
                       DESC

  s.homepage         = "https://github.com/appboy/appboy-segment-ios"
  s.license          =  { :type => 'MIT' }
  s.author           = { "Appboy" => "hello@braze.com" }
  s.source           = { :git => "https://github.com/appboy/appboy-segment-ios.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.dependency 'Analytics', '~> 3.0'
  s.default_subspec = 'Full-SDK'

  s.subspec 'Full-SDK' do |default|
    default.dependency 'Appboy-iOS-SDK', '~>3.21.0'
    default.source_files = 'Pod/Classes/**/*'
  end

  s.subspec 'Core' do |core|
    core.dependency 'Appboy-iOS-SDK/Core', '~>3.21.0'
    core.source_files = 'Pod/Classes/**/*'
  end

  s.subspec 'InAppMessage' do |iam|
    iam.dependency 'Appboy-iOS-SDK/InAppMessage', '~>3.21.0'
    iam.source_files = 'Pod/Classes/**/*'
  end

end
