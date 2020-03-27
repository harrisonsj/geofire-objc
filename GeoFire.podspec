Pod::Spec.new do |s|
  s.name         = "GeoFire"
  s.version      = "4.0.1"
  s.summary      = "Realtime location queries with Firebase."
  s.homepage     = "https://github.com/firebase/geofire-objc"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Firebase"
  s.source       = { :git => "https://github.com/firebase/geofire-objc.git", :tag => 'v' + s.version.to_s }
  s.source_files = "GeoFire/**/*.{h,m}"
  s.documentation_url   = "https://geofire-ios.firebaseapp.com/docs/"
  s.ios.deployment_target = '8.0'
  s.ios.dependency  'Firebase/Database', '~> 6.0'
  s.frameworks   = 'CoreLocation', 'FirebaseDatabase'
  s.requires_arc = true
  s.static_framework = true
end
