import SwiftUI

// MARK: - Card
public struct Card<Contents: View>: View {
	let action: (() -> Void)?
	let color: Color
	let contents: Contents

	public init(
		_ color: Color = .app.white,
		action: (() -> Void)? = nil,
		@ViewBuilder contents: () -> Contents
	) {
		self.action = action
		self.color = color
		self.contents = contents()
	}

	public var body: some View {
		if let action {
			Button(action: action) {
				contents
			}
			.buttonStyle(.cardButtonStyle(color))
		} else {
			contents
				.inCard(color)
		}
	}
}

public extension ButtonStyle where Self == CardButtonStyle {
	static func cardButtonStyle(_ color: Color) -> CardButtonStyle { CardButtonStyle(color: color) }
}

// MARK: - CardButtonStyle
public struct CardButtonStyle: ButtonStyle {
	public let color: Color

	public init(color: Color) {
		self.color = color
	}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.inCard(color, isPressed: configuration.isPressed)
	}
}

// MARK: - Speechbubble
public struct Speechbubble<Contents: View>: View {
	let insetContents: Bool
	let contents: Contents

	public init(insetContents: Bool = false, @ViewBuilder contents: () -> Contents) {
		self.insetContents = insetContents
		self.contents = contents()
	}

	public var body: some View {
		contents
			.padding(insetContents ? .small1 : 0)
			.inSpeechbubble
	}
}

// MARK: - InnerCard
public struct InnerCard<Contents: View>: View {
	let verticalSpacing: CGFloat
	let contents: Contents

	public init(verticalSpacing: CGFloat = 0, @ViewBuilder contents: () -> Contents) {
		self.verticalSpacing = verticalSpacing
		self.contents = contents()
	}

	public var body: some View {
		VStack(spacing: verticalSpacing) {
			contents
		}
		.inFlatCard
	}
}

extension View {
	/// Gives the view a white background, rounded corners (16 px), and a shadow, useful for root level cards
	fileprivate func inCard(_ color: Color = .white, isPressed: Bool = false) -> some View {
		background(isPressed ? .app.gray4 : color)
			.clipShape(RoundedRectangle(cornerRadius: .medium3))
			.cardShadow
	}

	public var inSpeechbubble: some View {
		padding(.bottom, SpeechbubbleShape.triangleSize.height)
			.background(.app.white)
			.clipShape(SpeechbubbleShape(cornerRadius: .medium3))
			.cardShadow
	}

	/// Gives the view rounded corners  (12 px) and no shadow, useful for inner views
	public var inFlatCard: some View {
		clipShape(RoundedRectangle(cornerRadius: .small1))
	}

	public var cardShadow: some View {
		shadow(color: .app.gray2.opacity(0.26), radius: .medium3, x: .zero, y: .small2)
	}
}

// MARK: - SpeechbubbleShape
public struct SpeechbubbleShape: Shape {
	let cornerRadius: CGFloat
	public static let triangleSize: CGSize = .init(width: 20, height: 10)
	public static let triangleInset: CGFloat = 50

	public init(cornerRadius: CGFloat) {
		self.cornerRadius = cornerRadius
	}

	public func path(in rect: CGRect) -> Path {
		let inner = rect.inset(by: .init(top: 0, left: 0, bottom: Self.triangleSize.height, right: 0))
		let arcCenters = inner.insetBy(dx: cornerRadius, dy: cornerRadius)
		return Path { path in
			path.addRelativeArc(center: .init(x: arcCenters.minX, y: arcCenters.minY),
			                    radius: cornerRadius,
			                    startAngle: .radians(.pi),
			                    delta: .radians(.pi / 2))

			path.addRelativeArc(center: .init(x: arcCenters.maxX, y: arcCenters.minY),
			                    radius: cornerRadius,
			                    startAngle: -.radians(.pi / 2),
			                    delta: .radians(.pi / 2))

			path.addRelativeArc(center: .init(x: arcCenters.maxX, y: arcCenters.maxY),
			                    radius: cornerRadius,
			                    startAngle: .zero,
			                    delta: .radians(.pi / 2))

			path.addLine(to: .init(x: inner.maxX - Self.triangleInset - Self.triangleSize.width / 2, y: inner.maxY))
			path.addLine(to: .init(x: inner.maxX - Self.triangleInset, y: rect.maxY))
			path.addLine(to: .init(x: inner.maxX - Self.triangleInset + Self.triangleSize.width / 2, y: inner.maxY))

			path.addRelativeArc(center: .init(x: arcCenters.minX, y: arcCenters.maxY),
			                    radius: cornerRadius,
			                    startAngle: .radians(.pi / 2),
			                    delta: .radians(.pi / 2))

			path.closeSubpath()
		}
	}
}
