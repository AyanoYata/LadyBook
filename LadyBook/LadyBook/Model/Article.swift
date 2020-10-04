import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//記事に持たせる機能class
class Article: Codable {
    
    //Top画面に表示される記事
    //article単位で1つのDocumentになる。
    var articleId: String
    var title: String
    var text: String?
    #warning("categoryとstyleの追加")
    //var category: String
    //var style: String
    
    
    //作成日
    var createdAt:Timestamp
    
    #warning("categoryとstyleの追加")
    init(articleId: String, title: String, text: String = "", createdAt:Timestamp) {
        self.articleId = articleId
        self.title = title
        self.text = text
        //self.category = category
        //self.style = style
        self.createdAt = createdAt
    }
}
