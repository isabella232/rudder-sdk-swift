workspace 'RudderStack.xcworkspace'
use_frameworks!
inhibit_all_warnings!

def shared_pods
    pod 'RudderStack', :path => '.'
end


target 'SampleObjC-iOS' do
    project 'Examples/SampleObjC-iOS/SampleObjC-iOS.xcodeproj'
    platform :ios, '13.0'
    shared_pods
end

target 'SampleSwift-iOS' do
    project 'Examples/SampleSwift-iOS/SampleSwift-iOS.xcodeproj'
    platform :ios, '13.0'
    shared_pods
end

target 'SampleObjC-tvOS' do
    project 'Examples/SampleObjC-tvOS/SampleObjC-tvOS.xcodeproj'
    platform :tvos, '11.0'
    shared_pods
end

target 'SampleObjC-watchOS WatchKit Extension' do
    project 'Examples/SampleObjC-watchOS/SampleObjC-watchOS.xcodeproj'
    platform :watchos, '7.3'
    shared_pods
end
