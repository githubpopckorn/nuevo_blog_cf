class ArticlesController < ApplicationController
	before_action :authenticate_user!, except:[:show,:index]
	before_action :set_article, except: [:index, :new, :create]
	#GET /articles
	def index
		#Obtiene todos los registros de la tabla
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		#Va a encontrar un registro por su id
		#@article = Article.find(params[:id])

		@article.update_visits_count
		@comment = Comment.new
		#devuelve un arreglo
		#Article.where("id: ?",params[:id])
		#Article.where("id: ? AND title",params[:id], paramas[:title])
		#Article.where("id: ? OR title",params[:id], paramas[:title])

		#WHERE
		#Article.where("body LIKE  ?","%hola%")

		#Articulos diferentes a los parametros
		#Article.where.not("id = 1")
		#Article.where.not("id = 1").count
	end

	#GET /articles/new
	def new
		@article = Article.new

	end

	#POST /articles
	def create
		# @article = Article.new(title: params[:article][:title], 
		# 						body:params[:article][:body])
		@article = current_user.articles.new(article_params)


		#@article.invalid?
		if @article.save
			redirect_to @article
		else
			render :new
		end		
	end


	def edit
		#@article = Article.find(params[:id])
	end

	#PUT /articles/:
	def update
		#@article.update_attributes({title: 'nuevo titulo'})
		#@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	#DELETE /articles/:id
	def destroy
		#@article = Article.find(params[:id])
		@article.destroy #Destroy elimina el objeto de la base de datos
		redirect_to articles_path
	end

	private
	def article_params
		params.require(:article).permit(:title, :body, :cover)
	end

	def set_article
		@article = Article.find(params[:id])
	end

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end
end