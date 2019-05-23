#
#  Be sure to run `pod spec lint YRSingleImageSelector.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "YRSingleImageSelector"
  spec.version      = "1.0.0"
  spec.summary      = "YRSingleImageSelector is used for pick image. this will help to get quick choose image from gallery or camera."

  spec.description  = "YRSingleImageSelector is used for pick image. this will help to get quick choose image from gallery or camera"

  spec.homepage     = "https://github.com/yogeshrathore123/YRSingleImageSelector"

  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "Yogesh rathore" => "yogeshrathore251@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/yogeshrathore123/YRSingleImageSelector.git", :tag => "#{spec.version}" }
  spec.source_files  = "YRSingleImageSelector"
  spec.swift_version = "4.2"

end
