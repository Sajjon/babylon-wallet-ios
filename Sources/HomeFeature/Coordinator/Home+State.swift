import AccountDetailsFeature
import AccountListFeature
import AccountPortfolio
import AccountPreferencesFeature
import Profile
import AggregatedValueFeature
import CreateAccountFeature
import WalletClient

// MARK: - Home
/// Namespace for HomeFeature
public enum Home {}

// MARK: Home.State
public extension Home {
	// MARK: State
	struct State: Equatable {
        public var profileSnapshot: ProfileSnapshot
		public var accountPortfolioDictionary: AccountPortfolioDictionary

		// MARK: - Components
		public var header: Home.Header.State
		public var aggregatedValue: AggregatedValue.State
		public var accountList: AccountList.State
		public var visitHub: Home.VisitHub.State

		// MARK: - Children
		public var accountDetails: AccountDetails.State?
		public var accountPreferences: AccountPreferences.State?
		public var createAccount: CreateAccount.State?
		public var transfer: AccountDetails.Transfer.State?

		public init(
            profileSnapshot: ProfileSnapshot,
			accountPortfolioDictionary: AccountPortfolioDictionary = [:],
			header: Home.Header.State = .init(),
			aggregatedValue: AggregatedValue.State = .init(),
			accountList: AccountList.State = .init(accounts: []),
			visitHub: Home.VisitHub.State = .init(),
			accountDetails: AccountDetails.State? = nil,
			accountPreferences: AccountPreferences.State? = nil,
			createAccount: CreateAccount.State? = nil,
			transfer: AccountDetails.Transfer.State? = nil
		) {
            self.profileSnapshot = profileSnapshot
			self.accountPortfolioDictionary = accountPortfolioDictionary
			self.header = header
			self.aggregatedValue = aggregatedValue
			self.accountList = accountList
			self.visitHub = visitHub
			self.accountDetails = accountDetails
			self.accountPreferences = accountPreferences
			self.createAccount = createAccount
			self.transfer = transfer
		}
	}
}

#if DEBUG
public extension ProfileSnapshot {
    static let placeholder: Self = {
        fatalError()
    }()
}

public extension Home.State {
	static let placeholder = Home.State(
        profileSnapshot: .placeholder,
		header: .init(hasNotification: false),
		aggregatedValue: .placeholder,
		visitHub: .init()
	)
}
#endif
