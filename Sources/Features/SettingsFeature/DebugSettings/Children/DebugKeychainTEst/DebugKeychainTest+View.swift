import FeaturePrelude
#if DEBUG
extension DebugKeychainTest.State {
	var viewState: DebugKeychainTest.ViewState {
		.init(status: status)
	}
}

// MARK: - DebugKeychainTest.View
extension DebugKeychainTest {
	public struct ViewState: Equatable {
		let status: DebugKeychainTest.Status
		var canTest: Bool { status.canTest }
	}

	@MainActor
	public struct View: SwiftUI.View {
		private let store: StoreOf<DebugKeychainTest>

		public init(store: StoreOf<DebugKeychainTest>) {
			self.store = store
		}

		public var body: some SwiftUI.View {
			WithViewStore(store, observe: \.viewState, send: { .view($0) }) { viewStore in
				VStack(alignment: .center) {
					Text("This demo will create 10 Tasks run in parallel, each trying to load-else-generate-and-save some data for two different keys, one key for `auth` and one for `no auth`.\n\nThe test succeeds if only **one single** data was produced by the tasks, asserting that the operation is *atomic* and *data race free*.\n\nThe `Auth Test` also tests that the operation is **not** performed on the main thread, which it must not be.")
						.font(.app.body1Regular)

					Separator()

					StatusView(status: viewStore.status)

					Separator()

					if viewStore.canTest {
						VStack {
							Button("`Auth Test`") {
								viewStore.send(.testAuth)
							}
							Text("**Should** prompted for biometrics *many* times.")
								.font(.app.resourceLabel)
						}
						Separator()
						VStack {
							Button("`No Auth Test`") {
								viewStore.send(.testNoAuth)
							}
							Text("Should **not** prompt for biometrics.")
								.font(.app.resourceLabel)
						}
					} else {
						Button("Restart") {
							viewStore.send(.reset)
						}
					}
				}
				.buttonStyle(.primaryRectangular)
				.font(.title)
				.padding()
				.onAppear { viewStore.send(.appeared) }
			}
		}
	}
}

struct StatusView: View {
	let status: DebugKeychainTest.Status
	var body: some View {
		HStack {
			Circle().fill(status.color)
				.frame(width: 30, height: 30)
			Text("`\(status.description)`")
			Spacer(minLength: 0)
		}
	}
}

extension DebugKeychainTest.Status {
	var canTest: Bool {
		switch self {
		case .initialized: return true
		default: return false
		}
	}

	var description: String {
		switch self {
		case .new: return "New"
		case .initializing: return "Initializing"
		case let .failedToInitialize(error): return "Failed to initialize \(error)"
		case .initialized: return "Initialized"
		case let .error(error): return "Error: \(error)"
		case .finishedSuccessfully: return "Success"
		case let .finishedWithFailure(failure): return "Failed: \(failure)"
		}
	}

	var color: Color {
		switch self {
		case .new: return .gray
		case .initializing: return .yellow
		case .failedToInitialize: return .red
		case .initialized: return .blue
		case .error: return .red
		case .finishedSuccessfully: return .green
		case .finishedWithFailure: return .orange
		}
	}
}

#endif
