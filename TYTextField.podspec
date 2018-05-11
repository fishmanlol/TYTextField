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

  s.license      = "MIT"

  s.author       = { "werur" => "werurty@163.com"}

  s.summary = "A Customized UITextField"

  s.platform     = :ios
  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/fishmanlol/TYTextField.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "TYTextField", "TYTextField/**/*.{swift}"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  s.resources = "TYTextField/Resources/*"

  s.swift_version = "4.0"


end
