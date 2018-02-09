//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

let nibFile = NSNib.Name(rawValue:"MyView")
var topLevelObjects : NSArray?

Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)
let views = (topLevelObjects as! Array<Any>).filter { $0 is NSView }

// Present the view in Playground
PlaygroundPage.current.liveView = views[0] as! NSView

PlaygroundPage.current.liveView

let loc = Locale(identifier: "zh-Hans")
loc.languageCode
loc.debugDescription

Locale.availableIdentifiers.filter{$0.hasPrefix("zh")}

Locale.canonicalLanguageIdentifier(from: "zh")
