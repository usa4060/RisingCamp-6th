
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
//    let page, perPage, totalCount, currentCount: Int
//    let matchCount: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    var resCase : Int
    var country : String? = " "
    var resName : String
    var phoneNum : String? = " "
    var address1: String? = " "
    var address2 : String? = " "
    var mainFood : String? = " "
    var x_pose : String? = " "
    var y_pose : String? = " "
    var introduce: String? = " "

    enum CodingKeys: String, CodingKey {
        case resCase = "종류(01한식,02중식,03일식,04양식,05기타외국음식,06디저트/카페)"
        case country = "테마(국가)"
        case resName = "업소명"
        case phoneNum = "전화번호"
        case address1 = "주소1"
        case address2 = "주소2"
        case mainFood = "주요요리"
        case x_pose = "위도"
        case y_pose = "경도"
        case introduce = "사장님이자랑하는내가게한마디"
    }
    
}
