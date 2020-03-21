platform :ios, '12.0'

workspace 'App.xcworkspace'
project 'App.xcodeproj'

def weather_search_pod
  pod 'WeatherSearch', :path => 'DevPods/WeatherSearch', :testspecs => ['Tests']
end

def development_pods
  weather_search_pod
end

target 'App' do
  use_frameworks!
  # Pods for App
  development_pods
end

target 'WeatherSearch_Example' do
  use_frameworks!
  project 'DevPods/WeatherSearch/Example/WeatherSearch.xcodeproj'
  weather_search_pod
end
