Pod::Spec.new do |s|
  s.name     = 'OrderedDictionary'
  s.version  = '2.0.0'
  s.platform = :ios, '8.0'
  s.summary  = "#{s.name}"
  s.homepage = "https://github.com/lukaskubanek/#{s.name}"
  s.author   = { 'Lukas Kubanek' => 'lukaskubanek.com' }
  s.source   = { :git => "https://github.com/lukaskubanek/#{s.name}.git" }
  s.source_files = 'Sources/*.{swift}'
  s.requires_arc = true
end