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
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `README.md`.
    static let readmeMd = Rswift.FileResource(bundle: R.hostingBundle, name: "README", pathExtension: "md")

    /// `bundle.url(forResource: "README", withExtension: "md")`
    static func readmeMd(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.readmeMd
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 28 images.
  struct image {
    /// Image `BaseVCBackGroundImg`.
    static let baseVCBackGroundImg = Rswift.ImageResource(bundle: R.hostingBundle, name: "BaseVCBackGroundImg")
    /// Image `Bubble_Delete`.
    static let bubble_Delete = Rswift.ImageResource(bundle: R.hostingBundle, name: "Bubble_Delete")
    /// Image `Bubble_Play`.
    static let bubble_Play = Rswift.ImageResource(bundle: R.hostingBundle, name: "Bubble_Play")
    /// Image `Bubble_Rename`.
    static let bubble_Rename = Rswift.ImageResource(bundle: R.hostingBundle, name: "Bubble_Rename")
    /// Image `Discover_selected`.
    static let discover_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "Discover_selected")
    /// Image `Discover_unselected`.
    static let discover_unselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "Discover_unselected")
    /// Image `HUD_Error`.
    static let hud_Error = Rswift.ImageResource(bundle: R.hostingBundle, name: "HUD_Error")
    /// Image `HUD_Right`.
    static let hud_Right = Rswift.ImageResource(bundle: R.hostingBundle, name: "HUD_Right")
    /// Image `TTAddPhotoBanner_defaultAddIcon`.
    static let ttAddPhotoBanner_defaultAddIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAddPhotoBanner_defaultAddIcon")
    /// Image `TTAvatar_default`.
    static let ttAvatar_default = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAvatar_default")
    /// Image `TTAvatar_man`.
    static let ttAvatar_man = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAvatar_man")
    /// Image `TTAvatar_woman`.
    static let ttAvatar_woman = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTAvatar_woman")
    /// Image `TTTest1`.
    static let ttTest1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTTest1")
    /// Image `TTTest`.
    static let ttTest = Rswift.ImageResource(bundle: R.hostingBundle, name: "TTTest")
    /// Image `back1`.
    static let back1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "back1")
    /// Image `common_push`.
    static let common_push = Rswift.ImageResource(bundle: R.hostingBundle, name: "common_push")
    /// Image `homeSelected`.
    static let homeSelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "homeSelected")
    /// Image `homeUnselected`.
    static let homeUnselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "homeUnselected")
    /// Image `icon_addr_gray`.
    static let icon_addr_gray = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_addr_gray")
    /// Image `it`.
    static let it = Rswift.ImageResource(bundle: R.hostingBundle, name: "it")
    /// Image `lucency`.
    static let lucency = Rswift.ImageResource(bundle: R.hostingBundle, name: "lucency")
    /// Image `nav_rightArrow`.
    static let nav_rightArrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "nav_rightArrow")
    /// Image `personSelected`.
    static let personSelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "personSelected")
    /// Image `personUnselected`.
    static let personUnselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "personUnselected")
    /// Image `性别女1`.
    static let 性别女1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "性别女1")
    /// Image `性别女2`.
    static let 性别女2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "性别女2")
    /// Image `性别男1`.
    static let 性别男1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "性别男1")
    /// Image `性别男2`.
    static let 性别男2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "性别男2")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "BaseVCBackGroundImg", bundle: ..., traitCollection: ...)`
    static func baseVCBackGroundImg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.baseVCBackGroundImg, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Bubble_Delete", bundle: ..., traitCollection: ...)`
    static func bubble_Delete(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bubble_Delete, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Bubble_Play", bundle: ..., traitCollection: ...)`
    static func bubble_Play(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bubble_Play, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Bubble_Rename", bundle: ..., traitCollection: ...)`
    static func bubble_Rename(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bubble_Rename, compatibleWith: traitCollection)
    }
    #endif

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
    /// `UIImage(named: "HUD_Error", bundle: ..., traitCollection: ...)`
    static func hud_Error(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.hud_Error, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HUD_Right", bundle: ..., traitCollection: ...)`
    static func hud_Right(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.hud_Right, compatibleWith: traitCollection)
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
    /// `UIImage(named: "back1", bundle: ..., traitCollection: ...)`
    static func back1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "common_push", bundle: ..., traitCollection: ...)`
    static func common_push(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.common_push, compatibleWith: traitCollection)
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
    /// `UIImage(named: "icon_addr_gray", bundle: ..., traitCollection: ...)`
    static func icon_addr_gray(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_addr_gray, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "it", bundle: ..., traitCollection: ...)`
    static func it(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.it, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "lucency", bundle: ..., traitCollection: ...)`
    static func lucency(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lucency, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "nav_rightArrow", bundle: ..., traitCollection: ...)`
    static func nav_rightArrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.nav_rightArrow, compatibleWith: traitCollection)
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

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "性别女1", bundle: ..., traitCollection: ...)`
    static func 性别女1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.性别女1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "性别女2", bundle: ..., traitCollection: ...)`
    static func 性别女2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.性别女2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "性别男1", bundle: ..., traitCollection: ...)`
    static func 性别男1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.性别男1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "性别男2", bundle: ..., traitCollection: ...)`
    static func 性别男2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.性别男2, compatibleWith: traitCollection)
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
      #if os(iOS) || os(tvOS)
      try main.validate()
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

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController

      let bundle = R.hostingBundle
      let name = "Main"

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
