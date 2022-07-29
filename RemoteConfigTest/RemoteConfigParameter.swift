import Foundation
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

struct RemoteConfigParameter {

    /// 初期値のディクショナリー
    static let defaultConfigValues: [String: NSObject] = {
        var defaultDictionary = [String: NSObject]()
        for parameter in ParameterType.allCases {
            defaultDictionary.updateValue(parameter.defaultValue, forKey: parameter.key)
        }
        return defaultDictionary
    }()

    private let remoteConfig: RemoteConfig

    init(with remoteConfig: RemoteConfig) {
        self.remoteConfig = remoteConfig
    }

    /// Remote Configのパラメータタイプ
    enum ParameterType: String, CaseIterable {
        case isUnderMaintenance
        case maintenanceMessage

        var key: String {
            return self.rawValue
        }

        var defaultValue: NSObject {

            switch self {
            case .isUnderMaintenance:
                return false as NSObject
            case .maintenanceMessage:
                return "メンテナンス中" as NSObject
            }
        }
    }

    /// メンテナンス中かどうか
    var isUnderMaintenance: Bool {
        do {
            return try decodedValue(.isUnderMaintenance)
        }
        catch {
            return ParameterType.isUnderMaintenance.defaultValue as! Bool
        }
    }

    /// メンテナンスメッセージ
    var maintenanceMessage: String {
        do {
            return try decodedValue(.maintenanceMessage)
        }
        catch {
            return ParameterType.maintenanceMessage.defaultValue as! String
        }
    }

    // MARK: - Private func

    /// Remote Configで取得している値をデコードして返す
    /// - Parameter parameter: Remote Configパラメータタイプ
    /// - Returns: デコードされたRemote Configの値を返す
    private func decodedValue<T>(_ parameter: ParameterType) throws -> T {

        switch parameter {
        case .isUnderMaintenance:
            return try remoteConfig[parameter.key].decoded(asType: Bool.self) as! T
        case .maintenanceMessage:
            return try remoteConfig[parameter.key].decoded(asType: String.self) as! T
        }
    }
}
