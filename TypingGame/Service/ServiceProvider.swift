//
//  ServiceProvider.swift
//  TypingGame
//
//  Created by adam tecle on 3/24/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

protocol ServiceProviderType: class {
    var stylingService: InputDisplayStylingServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var stylingService: InputDisplayStylingServiceType = InputDisplayStylingService()
}

