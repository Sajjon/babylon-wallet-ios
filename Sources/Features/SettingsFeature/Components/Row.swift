import Common
import DesignSystem
import SwiftUI

// MARK: - Row
struct Row: View {
	let title: String
	let icon: Image
	let action: () -> Void

	init(
		_ title: String,
		icon: Image,
		action: @escaping () -> Void
	) {
		self.title = title
		self.icon = icon
		self.action = action
	}
}

extension Row {
	var body: some View {
		Button(
			action: {
				action()
			}, label: {
				ZStack {
					HStack {
						icon
							.frame(.verySmall)
							.cornerRadius(.small3)

						Spacer()
							.frame(width: 20)

						Text(title)
							.textStyle(.body1Header)
							.foregroundColor(.app.gray1)

						Spacer()

						Image(asset: AssetResource.chevronRight)
					}

					VStack {
						Spacer()
						Separator()
					}
				}
				.padding(.horizontal, .medium1)
				.foregroundColor(.app.gray1)
				.frame(height: .largeButtonHeight)
			}
		)
		.buttonStyle(SettingsRowStyle())
	}
}

// MARK: - SettingsRowStyle
struct SettingsRowStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.background(configuration.isPressed ? Color.app.gray4 : Color.app.white)
	}
}

// MARK: - Row_Previews
struct Row_Previews: PreviewProvider {
	static var previews: some View {
		Row("Title", icon: Image(systemName: "wallet.pass"), action: {})
	}
}