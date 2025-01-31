//
//  File.swift
//  
//
//  Created by Fredrik Strand Oseberg on 27/05/2021.
//

import Foundation
@testable import UnleashProxyClientSwift

func generateBasicTestToggleMap() -> [String: Toggle] {
    let toggleOne = Toggle(name: "Test", enabled: true, variant: Variant(name: "disabled", enabled: false, payload: nil))
    let toggleTwo = Toggle(name: "TestTwo", enabled: false, variant: Variant(name: "disabled", enabled: false, payload: nil))
    var toggleMap: [String: Toggle] = [:]
    toggleMap[toggleOne.name] = toggleOne
    toggleMap[toggleTwo.name] = toggleTwo
    
    return toggleMap
}

func generateTestToggleMapWithVariant() -> [String: Toggle] {
    let variantA = Variant(name: "TestA", enabled: true, payload: nil)
    let variantB = Variant(name: "TestB", enabled: false, payload: nil)
    let toggleOne = Toggle(name: "Test", enabled: true, variant: variantA)
    let toggleTwo = Toggle(name: "TestTwo", enabled: true, variant: variantB)
    
    var toggleMap: [String: Toggle] = [:]
    toggleMap[toggleOne.name] = toggleOne
    toggleMap[toggleTwo.name] = toggleTwo
    
    return toggleMap
}

func setup(dataGenerator: @escaping () -> [String: Toggle]) -> UnleashClient {
    let poller = MockPoller(callback: dataGenerator, unleashUrl: "https://app.unleash-hosted.com/hosted/api/proxy", apiKey: "SECRET")
    
    let unleash = UnleashProxyClientSwift.UnleashClient(unleashUrl: "https://app.unleash-hosted.com/hosted/api/proxy", clientKey: "dss22d", refreshInterval: 15, appName: "test", environment: "dev", poller: poller)
    
    unleash.start()
    return unleash
}
