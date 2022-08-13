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
        case pickupArticle

        var key: String {
            return self.rawValue
        }

        var defaultValue: NSObject {

            switch self {
            case .pickupArticle:
                return """
                {
                    "title": "",
                    "message": "",
                    "imageUrl": ""
                }
                """ as NSObject
            }
        }
    }

    var pickupArticle: String {
        do {
            return try decodedValue(.pickupArticle)
        }
        catch {
            return ParameterType.pickupArticle.defaultValue as! String
        }
    }

    // MARK: - Private func

    /// Remote Configで取得している値をデコードして返す
    /// - Parameter parameter: Remote Configパラメータタイプ
    /// - Returns: デコードされたRemote Configの値を返す
    private func decodedValue<T>(_ parameter: ParameterType) throws -> T {

        switch parameter {
        case .pickupArticle:
            return try remoteConfig[parameter.key].decoded(asType: String.self) as! T
        }
    }
}
