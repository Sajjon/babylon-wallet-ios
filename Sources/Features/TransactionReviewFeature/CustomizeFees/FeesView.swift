import FeaturePrelude
import TransactionClient

// MARK: - FeesView
struct FeesView: View {
	struct ViewState: Equatable, Sendable {
		let feeViewStates: IdentifiedArrayOf<FeeViewState>
		let totalFee: BigDecimal
		let isAdvancedMode: Bool
	}

	let viewState: ViewState

	var body: some View {
		VStack(spacing: .small1) {
			HStack {
				Text(L10n.TransactionReview.CustomizeNetworkFeeSheet.feeBreakdownTitle)
					.textStyle(.body1Link)
					.foregroundColor(.app.gray2)
					.textCase(.uppercase)
				Spacer()
			}
			.padding(.horizontal, .medium1)

			VStack(spacing: .small1) {
				ForEach(viewState.feeViewStates) { viewState in
					feeView(state: viewState)
				}

				Divider()

				transactionFeeView(fee: viewState.totalFee.format(), isAdvancedMode: viewState.isAdvancedMode)
			}
			.padding(.medium1)
			.background(.app.gray5)
		}
	}

	@ViewBuilder
	func transactionFeeView(fee: String, isAdvancedMode: Bool) -> some SwiftUI.View {
		HStack {
			VStack(spacing: .zero) {
				Text(L10n.TransactionReview.CustomizeNetworkFeeSheet.totalFee)
					.textStyle(.body1Link)
					.foregroundColor(.app.gray2)
					.textCase(.uppercase)
				if isAdvancedMode {
					Text(L10n.TransactionReview.CustomizeNetworkFeeSheet.TotalFee.info)
						.textStyle(.body1Link)
						.foregroundColor(.app.gray2)
				}
			}
			Spacer()
			Text(fee)
				.textStyle(.body1Header)
				.foregroundColor(.app.gray1)
		}
	}

	@ViewBuilder
	func feeView(state: FeeViewState) -> some SwiftUI.View {
		HStack {
			Text(state.name)
				.textStyle(.body1Link)
				.foregroundColor(.app.gray2)
				.textCase(.uppercase)
			Spacer()
			Text(state.amount.formatted(state.isUserConfigurable))
				.textStyle(.body1HighImportance)
				.foregroundColor(state.amount == .zero ? .app.gray2 : .app.gray1)
		}
	}
}

// MARK: - FeeViewState
struct FeeViewState: Equatable, Sendable, Identifiable {
	var id: String { name }

	let name: String
	let amount: BigDecimal
	let isUserConfigurable: Bool
}

extension TransactionFee.AdvancedFeeCustomization {
	var viewStates: IdentifiedArrayOf<FeeViewState> {
		.init(uncheckedUniqueElements: [
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.networkExecution, amount: feeSummary.executionCost, isUserConfigurable: false),
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.networkFinalization, amount: feeSummary.finalizationCost, isUserConfigurable: false),
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.effectiveTip, amount: tipAmount, isUserConfigurable: true),
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.networkStorage, amount: feeSummary.storageExpansionCost, isUserConfigurable: false),
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.padding, amount: paddingFee, isUserConfigurable: true),
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.royalties, amount: feeSummary.royaltyCost, isUserConfigurable: false),
		])
	}
}

extension TransactionFee.NormalFeeCustomization {
	var viewStates: IdentifiedArrayOf<FeeViewState> {
		.init(uncheckedUniqueElements: [
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.networkFee, amount: networkFee, isUserConfigurable: false),
			.init(name: L10n.TransactionReview.CustomizeNetworkFeeSheet.royaltyFee, amount: royaltyFee, isUserConfigurable: false),
		])
	}
}

extension BigDecimal {
	func formatted(_ showsZero: Bool) -> String {
		if !showsZero, self == .zero {
			return L10n.TransactionReview.CustomizeNetworkFeeSheet.noneDue
		}
		return L10n.TransactionReview.xrdAmount(format())
	}
}