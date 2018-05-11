#
#  Be sure to run `pod spec lint TYTextField.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TYTextField"
  s.version      = "0.0.2"
  s.summary      = "A Customized UITextField"

  s.description  = <<-DESC
                  An simple customized UITextField with righview.
                   DESC

  s.homepage     = "https://github.com/fishmanlol/TYTextField"

  s.license = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "werur" => "werurty@163.com"}

  s.summary = "A Customized UITextField"

  s.platform     = :ios
  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/fishmanlol/TYTextField.git", :tag => "#{s.version}" }

  s.source_files  = "TYTextField", "TYTextField/**/*.{swift}"

  s.resources = "./*.png"

  s.swift_version = "4.0"

end
