import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//記事に持たせる機能class
class Article: Codable {
    
    //Top画面に表示される記事
    //article単位で1つのDocumentになる。
    var articleId: String
    var title: String?
    var text: String?
    //var imageURL: String?
    var createdAt:Timestamp
    //var category: String
    //var style: String
    

    //init(articleId: String, title: String = "", text: String = "", createdAt:Timestamp, category: String, style: String) {
    init(articleId: String, title: String = "", text: String = "", createdAt:Timestamp) {
        self.articleId = articleId
        self.title = title
        self.text = text
        self.createdAt = createdAt
        //self.category = category
        //self.style = style
    }
}
