class ArticleMailer < ApplicationMailer
    def new_article(article)
        @article = article
        
        User.all.each do |user|
            mail(to: user.email, subject: "Tenemos un nuevo articulo que te podría interesar")
        end
    end
end
