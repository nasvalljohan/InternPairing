import SwiftUI

struct TextFieldModifier: ViewModifier {
    let fontSize: CGFloat
    let backgroundColor: Color
    let textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: fontSize))
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 5).fill(backgroundColor))
            .foregroundColor(textColor)
    }
}

extension View {
    func textFieldModifier(fontSize: CGFloat = 14, backgroundColor: Color = .blue, textColor: Color = .white) -> some View {
        self.modifier(TextFieldModifier(fontSize: fontSize, backgroundColor: backgroundColor, textColor: textColor))
    }
}
