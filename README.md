# YRSingleImageSelector
YRSingleImageSelector using this we can select image from gallery or phots.


# Use

In podfile write

pod 'YRSingleImageSelector', :git => 'https://github.com/yogeshrathore123/YRSingleImageSelector.git', :tag => '1.0.0'

## Uses in ViewController

import YRSingleImageSelector

In Storyboard take UIView, Select UIView


Click on show the identity inspectors 
Choose Class YRSingleImageSelector

give Outlet connection

@IBOutlet weak var imageSelectorView: YRSingleImageSelector!

Go to info file give permission

Privacy - Camera Usage Description and Privacy - Photo Library Usage Description
