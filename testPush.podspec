
Pod::Spec.new do |s|
  s.name             = 'testPush'
  s.version          = '0.1.0'
  s.summary          = 'A short description of testPush.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ModuleCreation/TestPush'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TPQuietBro' => 'tangpeng@icarbonx.com' }
  s.source           = { :git => 'https://github.com/ModuleCreation/TestPush.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'testPush/Classes/**/*'
  
  s.dependency 'JPush'
end
