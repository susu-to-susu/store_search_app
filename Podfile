platform :ios, '12.0'

def testing_pods
  pod 'Quick', '~> 1.1'
  pod 'Nimble', '~> 6.1'
  pod 'OHHTTPStubs', '~> 6.0'
  pod 'OHHTTPStubs/Swift'
end

def app_pods
  pod 'Japx/CodableAlamofire'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'SVProgressHUD', '~> 2.1'
  pod 'AlamofireImage', '~> 3.2'
  pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
end

target 'shop_search' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for store_search
  app_pods

  target 'shop_searchTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'shop_searchUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end
