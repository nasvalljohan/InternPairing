import Foundation
import SwiftUI

protocol ColorThemeProtocol: ObservableObject {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var tertiaryColor: Color { get }
}

class LightModeTheme: ObservableObject, ColorThemeProtocol {
    let primaryColor: Color = .red
    let secondaryColor: Color = .black
    let tertiaryColor: Color = .white
}

class DarkModeTheme: ObservableObject, ColorThemeProtocol {
    let primaryColor: Color = .blue
    let secondaryColor: Color = .white
    let tertiaryColor: Color = .black
}
