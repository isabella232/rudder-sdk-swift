//
//  RSMessage.swift
//  RudderStack
//
//  Created by Pallab Maiti on 02/03/22.
//  Copyright © 2022 Rudder Labs India Pvt Ltd. All rights reserved.
//

import Foundation

public protocol RSMessage {
    var type: RSMessageType { get set }
    var anonymousId: String? { get set }
    var messageId: String? { get set }
    var userId: String? { get set }
    var timestamp: String? { get set }
    var context: MessageContext? { get set }
    var integrations: MessageIntegrations? { get set }
    var option: RSOption? { get set }
    var channel: String? { get set }
    
    func toDict() -> [String: Any]
}

public struct TrackMessage: RSMessage {
    public var type: RSMessageType = .track
    public var anonymousId: String?
    public var messageId: String?
    public var userId: String?
    public var timestamp: String?
    public var context: MessageContext?
    public var integrations: MessageIntegrations?
    public var option: RSOption?
    public var channel: String?
    
    public let event: String
    public let properties: TrackProperties?

    public func toDict() -> [String: Any] {
        var dictionary = staticDictionary()
        dynamicDictionary(dictionary: &dictionary)
        return dictionary
    }
    
    func dynamicDictionary(dictionary: inout [String: Any]) {
        dictionary["event"] = event
        dictionary["properties"] = properties
        dictionary["userId"] = userId
    }
    
    init(event: String, properties: TrackProperties?, option: RSOption? = nil) {
        self.event = event
        self.properties = properties
        self.option = option
    }
}

public struct IdentifyMessage: RSMessage {
    public var type: RSMessageType = .identify
    public var anonymousId: String?
    public var messageId: String?
    public var userId: String?
    public var timestamp: String?
    public var context: MessageContext?
    public var integrations: MessageIntegrations?
    public var option: RSOption?
    public var channel: String?
    
    public var traits: IdentifyTraits?
    
    public func toDict() -> [String: Any] {
        var dictionary = staticDictionary()
        dynamicDictionary(dictionary: &dictionary)
        return dictionary
    }
    
    func dynamicDictionary(dictionary: inout [String: Any]) {
        dictionary[keyPath: "context.traits"] = traits
        dictionary["event"] = "identify"
        dictionary["userId"] = userId
    }
    
    init(userId: String, traits: IdentifyTraits? = nil, option: RSOption? = nil) {
        self.userId = userId
        self.traits = traits
        self.option = option
    }
}

public struct ScreenMessage: RSMessage {
    public var type: RSMessageType = .screen
    public var anonymousId: String?
    public var messageId: String?
    public var userId: String?
    public var timestamp: String?
    public var context: MessageContext?
    public var integrations: MessageIntegrations?
    public var option: RSOption?
    public var channel: String?

    public let name: String
    public let category: String?
    public let properties: ScreenProperties?

    public func toDict() -> [String: Any] {
        var dictionary = staticDictionary()
        dynamicDictionary(dictionary: &dictionary)
        return dictionary
    }
    
    func dynamicDictionary(dictionary: inout [String: Any]) {
        dictionary["properties"] = properties
        dictionary["event"] = name
        dictionary["userId"] = userId
        dictionary["category"] = category
    }
    
    init(title: String, category: String? = nil, properties: ScreenProperties? = nil, option: RSOption? = nil) {
        self.name = title
        self.category = category
        self.properties = properties
        self.option = option
    }
}

public struct GroupMessage: RSMessage {
    public var type: RSMessageType = .group
    public var anonymousId: String?
    public var messageId: String?
    public var userId: String?
    public var timestamp: String?
    public var context: MessageContext?
    public var integrations: MessageIntegrations?
    public var option: RSOption?
    public var channel: String?

    public let groupId: String
    public let traits: GroupTraits?
    
    public func toDict() -> [String: Any] {
        var dictionary = staticDictionary()
        dynamicDictionary(dictionary: &dictionary)
        return dictionary
    }
    
    func dynamicDictionary(dictionary: inout [String: Any]) {
        dictionary["traits"] = traits
        dictionary["groupId"] = groupId
        dictionary["userId"] = userId
    }
    
    init(groupId: String, traits: GroupTraits? = nil, option: RSOption? = nil) {
        self.groupId = groupId
        self.traits = traits
        self.option = option
    }
}

public struct AliasMessage: RSMessage {
    public var type: RSMessageType = .alias
    public var anonymousId: String?
    public var messageId: String?
    public var userId: String?
    public var timestamp: String?
    public var context: MessageContext?
    public var integrations: MessageIntegrations?
    public var option: RSOption?
    public var channel: String?

    public var previousId: String?
    
    public func toDict() -> [String: Any] {
        var dictionary = staticDictionary()
        dynamicDictionary(dictionary: &dictionary)
        return dictionary
    }

    func dynamicDictionary(dictionary: inout [String: Any]) {
        dictionary["userId"] = userId
        dictionary["previousId"] = previousId
    }
        
    init(newId: String, option: RSOption? = nil) {
        self.userId = newId
        self.option = option
    }    
}

// MARK: - RawEvent data helpers

extension RSMessage {
    internal mutating func applyRawMessageData(message: RSMessage?) {
        if let e = message {
            anonymousId = e.anonymousId
            messageId = e.messageId
            userId = e.userId
            timestamp = e.timestamp
            context = e.context
            integrations = e.integrations
        }
    }

    internal func applyRawEventData() -> Self {
        var result: Self = self
        result.anonymousId = RSUserDefaults.getAnonymousId()
        result.messageId = String(format: "%ld-%@", RSUtils.getTimeStamp(), RSUtils.getUniqueId())
        result.timestamp = RSUtils.getTimestampString()
        result.channel = "mobile"
        return result
    }
    
    func staticDictionary() -> [String: Any] {
        var dict = ["messageId": messageId ?? "",
                    "anonymousId": anonymousId ?? "",
                    "channel": channel ?? "",
                    "originalTimestamp": timestamp ?? "",
                    "type": type.rawValue] as [String: Any]
        if let context = context {
            dict["context"] = context
        }
        if let integrations = integrations {
            dict["integrations"] = integrations
        }
        return dict
    }
}
