import Foundation

struct ModelData {
    var fortuneCookie: FortuneCookie = load("FortuneCookieData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    let languageCode = Locale.current.identifier.components(separatedBy: "_")[0]
    
    let resource = localizeFile(name: filename, languageCode: languageCode)
    
    guard let file = Bundle.main.url(forResource: resource, withExtension: nil)
    else {
        fatalError("메인 번들에서 '\(resource)' 파일을 찾을 수 없습니다.")
    }
    
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("메인 번들에서 '\(resource)'를 불러올 수 없습니다. \(error)")
    }
    
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("\(resource)을 \(T.self)로 파싱할 수 없습니다. \(error)")
    }
}

func localizeFile(name: String, languageCode: String) -> String {
    let locale = Language(rawValue: languageCode)
    
    if locale != nil {
        return "\(languageCode)_\(name)"
    } else {
        return "en_\(name)"
    }
}

enum Language: String {
    case ko
    case en
    case ja
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
}
