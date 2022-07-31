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
        case title
        case message
        case imageUrl

        var key: String {
            return self.rawValue
        }

        var defaultValue: NSObject {

            switch self {
            case .title:
                return "タイトル" as NSObject
            case .message:
                return "メッセージ" as NSObject
            case .imageUrl:
                return "https://beiz.jp/images_P/wallpaper/wallpaper_00458.jpg" as NSObject
            }
        }
    }

    var title: String {
        do {
            return try decodedValue(.title)
        }
        catch {
            return ParameterType.title.defaultValue as! String
        }
    }

    var message: String {
        do {
            return try decodedValue(.message)
        }
        catch {
            return ParameterType.message.defaultValue as! String
        }
    }

    var imageUrl: String {
        do {
            return try decodedValue(.imageUrl)
        }
        catch {
            return ParameterType.imageUrl.defaultValue as! String
        }
    }

    // MARK: - Private func

    /// Remote Configで取得している値をデコードして返す
    /// - Parameter parameter: Remote Configパラメータタイプ
    /// - Returns: デコードされたRemote Configの値を返す
    private func decodedValue<T>(_ parameter: ParameterType) throws -> T {

        switch parameter {
        case .title:
            return try remoteConfig[parameter.key].decoded(asType: String.self) as! T
        case .message:
            return try remoteConfig[parameter.key].decoded(asType: String.self) as! T
        case .imageUrl:
            return try remoteConfig[parameter.key].decoded(asType: String.self) as! T
        }
    }
}
