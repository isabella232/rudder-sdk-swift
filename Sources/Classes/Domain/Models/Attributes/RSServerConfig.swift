//
//  RSServerConfig.swift
//  RudderStack
//
//  Created by Pallab Maiti on 19/08/21.
//  Copyright © 2021 Rudder Labs India Pvt Ltd. All rights reserved.
//

import Foundation

@objc open class RSServerConfig: NSObject, Codable {
    
    struct Source: Codable {
        private let _id: String?
        var id: String {
            return _id ?? ""
        }
        
        private let _name: String?
        var name: String {
            return _name ?? ""
        }
        
        private let _writeKey: String?
        var writeKey: String {
            return _writeKey ?? ""
        }
        
        private let _enabled: Bool?
        var enabled: Bool {
            return _enabled ?? false
        }
        
        private let _sourceDefinitionId: String?
        var sourceDefinitionId: String {
            return _sourceDefinitionId ?? ""
        }
        
        private let _createdBy: String?
        var createdBy: String {
            return _createdBy ?? ""
        }
        
        private let _workspaceId: String?
        var workspaceId: String {
            return _workspaceId ?? ""
        }
        
        private let _deleted: Bool?
        var deleted: Bool {
            return _deleted ?? false
        }
        
        private let _createdAt: String?
        var createdAt: String {
            return _createdAt ?? ""
        }
        
        private let _updatedAt: String?
        var updatedAt: String {
            return _updatedAt ?? ""
        }
        
        let destinations: [RSDestination]?
        
        enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case _id = "id"
            case _name = "name"
            case _writeKey = "writeKey"
            case _enabled = "enabled"
            case _sourceDefinitionId = "sourceDefinitionId"
            case _createdBy = "createdBy"
            case _workspaceId = "workspaceId"
            case _deleted = "deleted"
            case _createdAt = "createdAt"
            case _updatedAt = "updatedAt"
            case destinations = "destinations"
        }
    }
    
    private let _config: Source?
    
    public var id: String {
        return _config?.id ?? ""
    }
    
    public var name: String {
        return _config?.name ?? ""
    }
    
    public var writeKey: String {
        return _config?.writeKey ?? ""
    }
    
    public var enabled: Bool {
        return _config?.enabled ?? false
    }
    
    public var sourceDefinitionId: String {
        return _config?.sourceDefinitionId ?? ""
    }
    
    public var createdBy: String {
        return _config?.createdBy ?? ""
    }
    
    public var workspaceId: String {
        return _config?.workspaceId ?? ""
    }
    
    public var deleted: Bool {
        return _config?.deleted ?? false
    }
    
    public var createdAt: String {
        return _config?.createdAt ?? ""
    }
    
    public var updatedAt: String {
        return _config?.updatedAt ?? ""
    }
    
    public var destinations: [RSDestination]? {
        return _config?.destinations
    }
    
    enum CodingKeys: String, CodingKey {
        case _config = "source"
    }
}

extension RSServerConfig {
    public func getDestination(by key: String) -> RSDestination? {
        if let destinations = destinations {
            if let destination = destinations.first(where: { $0.destinationDefinition?.displayName == key }) {
                return destination
            }
        }
        return nil
    }
}
