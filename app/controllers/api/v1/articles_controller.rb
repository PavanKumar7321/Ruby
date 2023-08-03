class Api::V1::ArticlesController < ApplicationController
  def index
    pavan = Article.all
    render json: pavan, status: :ok
  end

  def show
    article = Article.find(params[:id])
    if article
      render json: article, status: :ok
    else
      render json: { error: "Article not found" }, status: :not_found
    end
  end

  def create
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: :created
    else
      render json: { errors: "Error creating article..." }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find(params[:id])
    if article.update(arti_params)
      render json: article, status: :ok
    else
      render json: { errors: "Error updating article..." }, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    render json: { message: "Article deleted successfully" }, status: :ok
  end

  private

  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end
end
