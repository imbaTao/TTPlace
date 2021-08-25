//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    struct comAppleDeveloperApplesignin {
      static let `default` = infoPlistString(path: ["com.apple.developer.applesignin"], key: "Default") ?? "Default"

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `Emoji.plist`.
    static let emojiPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "Emoji", pathExtension: "plist")
    /// Resource file `README.md`.
    static let readmeMd = Rswift.FileResource(bundle: R.hostingBundle, name: "README", pathExtension: "md")

    /// `bundle.url(forResource: "Emoji", withExtension: "plist")`
    static func emojiPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.emojiPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "README", withExtension: "md")`
    static func readmeMd(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.readmeMd
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 19 images.
  struct image {
    /// Image `Discover_selected`.
    static let discover_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "Discover_selected")
    /// Image `Discover_unselected`.
    static let discover_unselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "Discover_unselected")
    /// Image `HTHudError`.
    static let htHudError = Rswift.ImageResource(bundle: R.hostingBundle, name: "HTHudError")
    /// Image `HTHudSuccess_white`.
    static let htHudSuccess_white = Rswift.ImageResource(bundle: R.hostingBundle, name: "HTHudSuccess_white")
    /// Image `HTHudSuccess`.
    static let htHudSuccess = Rswift.ImageResource(bundle: R.hostingBundle, name: "HTHudSuccess")
    /// Image `HTSVIndefiniteAnimatedViewWhiteCircle`.
    static let htsvIndefiniteAnimatedViewWhiteCircle = Rswift.ImageResource(bundle: R.hostingBundle, name: "HTSVIndefiniteAnimatedViewWhiteCircle")
    /// Image `NavigationBarBack`.
    static let navigationBarBack = Rswift.ImageResource(bundle: R.hostingBundle, name: "NavigationBarBack")
    /// Image `TTAddPhotoBanner_defaultAddIcon`.
    static let ttAddPhotoBanner_defaultAddIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAddPhotoBanner_defaultAddIcon")
    /// Image `TTAvatar_default`.
    static let ttAvatar_default = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAvatar_default")
    /// Image `TTAvatar_man`.
    static let ttAvatar_man = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAvatar_man")
    /// Image `TTAvatar_woman`.
    static let ttAvatar_woman = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAvatar_woman")
    /// Image `TTChatInput_Emoji`.
    static let ttChatInput_Emoji = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTChatInput_Emoji")
    /// Image `TTChatInput_keyboard`.
    static let ttChatInput_keyboard = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTChatInput_keyboard")
    /// Image `TTTest1`.
    static let ttTest1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTTest1")
    /// Image `TTTest`.
    static let ttTest = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTTest")
    /// Image `homeSelected`.
    static let homeSelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "homeSelected")
    /// Image `homeUnselected`.
    static let homeUnselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "homeUnselected")
    /// Image `personSelected`.
    static let personSelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "personSelected")
    /// Image `personUnselected`.
    static let personUnselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "personUnselected")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Discover_selected", bundle: ..., traitCollection: ...)`
    static func discover_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.discover_selected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Discover_unselected", bundle: ..., traitCollection: ...)`
    static func discover_unselected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.discover_unselected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HTHudError", bundle: ..., traitCollection: ...)`
    static func htHudError(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.htHudError, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HTHudSuccess", bundle: ..., traitCollection: ...)`
    static func htHudSuccess(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.htHudSuccess, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HTHudSuccess_white", bundle: ..., traitCollection: ...)`
    static func htHudSuccess_white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.htHudSuccess_white, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HTSVIndefiniteAnimatedViewWhiteCircle", bundle: ..., traitCollection: ...)`
    static func htsvIndefiniteAnimatedViewWhiteCircle(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.htsvIndefiniteAnimatedViewWhiteCircle, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "NavigationBarBack", bundle: ..., traitCollection: ...)`
    static func navigationBarBack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.navigationBarBack, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTAddPhotoBanner_defaultAddIcon", bundle: ..., traitCollection: ...)`
    static func ttAddPhotoBanner_defaultAddIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttAddPhotoBanner_defaultAddIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTAvatar_default", bundle: ..., traitCollection: ...)`
    static func ttAvatar_default(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttAvatar_default, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTAvatar_man", bundle: ..., traitCollection: ...)`
    static func ttAvatar_man(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttAvatar_man, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTAvatar_woman", bundle: ..., traitCollection: ...)`
    static func ttAvatar_woman(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttAvatar_woman, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTChatInput_Emoji", bundle: ..., traitCollection: ...)`
    static func ttChatInput_Emoji(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttChatInput_Emoji, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTChatInput_keyboard", bundle: ..., traitCollection: ...)`
    static func ttChatInput_keyboard(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttChatInput_keyboard, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTTest", bundle: ..., traitCollection: ...)`
    static func ttTest(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttTest, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TTTest1", bundle: ..., traitCollection: ...)`
    static func ttTest1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ttTest1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "homeSelected", bundle: ..., traitCollection: ...)`
    static func homeSelected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.homeSelected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "homeUnselected", bundle: ..., traitCollection: ...)`
    static func homeUnselected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.homeUnselected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "personSelected", bundle: ..., traitCollection: ...)`
    static func personSelected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.personSelected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "personUnselected", bundle: ..., traitCollection: ...)`
    static func personUnselected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.personUnselected, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `TTCollectionViewCell`.
    static let ttCollectionViewCell = _R.nib._TTCollectionViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TTCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.ttCollectionViewCell) instead")
    static func ttCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.ttCollectionViewCell)
    }
    #endif

    static func ttCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TTCollectionViewCell? {
      return R.nib.ttCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TTCollectionViewCell
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _TTCollectionViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TTCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TTCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TTCollectionViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
