import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class Article: Codable {
    
    //Top画面に表示される記事一覧。それぞれIdを取得
    var articleId: String
    var title: String
    var titleImage: String
    var text: String?
    var category: String
    var style: String
    
    
    //作成日、修正日
    var createdAt:Timestamp
    var updatedAt:Timestamp
    
    
    init(articleId: String, title: String, titleImage: String, text: String? = "", category: String, style: String, createdAt:Timestamp, updatedAt:Timestamp) {
        self.articleId = articleId
        self.title = title
        self.titleImage = titleImage
        self.text = text
        self.category = category
        self.style = style
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

