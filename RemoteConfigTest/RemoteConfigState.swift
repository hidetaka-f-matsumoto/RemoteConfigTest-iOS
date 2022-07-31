import SwiftUI
import FirebaseRemoteConfig

class RemoteConfigState: ObservableObject {

    /// fetchAndActivateを実施中ならtrue
    @Published var isFetchAndActivating = false

    private let remoteConfig: RemoteConfig
    private let remoteConfigParameter: RemoteConfigParameter

    // Remote Configの最小フェッチ間隔
    private let minimumFetchInterval: TimeInterval = {
    #if DEBUG
        return 0
    #else
        // デフォルト値 12時間(推奨)
        return 43200
    #endif
    }()

    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = minimumFetchInterval
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(RemoteConfigParameter.defaultConfigValues)
        remoteConfigParameter = RemoteConfigParameter(with: remoteConfig)

        fetchAndActive()
    }

    var title: String {
        return remoteConfigParameter.title
    }

    var message: String {
        return remoteConfigParameter.message
    }

    var imageUrl: URL? {
        return URL(string: remoteConfigParameter.imageUrl)
    }

    /// RemoteConfigの値をfetchしてactivateする
    private func fetchAndActive() {
        isFetchAndActivating = true

        Task {
            do {
                let _ = try await remoteConfig.fetchAndActivate()
                DispatchQueue.main.async {
                    self.isFetchAndActivating = false
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
