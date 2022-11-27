class TweetsController < ApplicationController
  def index
    @tweets = tweet.all
    render 'tweets/index' # http request points to route that points to here that points to index.jbuilder file
  end

  def index_by_current_user
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      @tweets = session.user.tweets
      render 'tweets/index' # http request points to route that points to here that points to index.jbuilder file
    else
      render json: { tweets: [] }
    end
  end

  def create
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create' # points to create.jbuilder file in tweets folder
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def destroy
    @tweet = tweet.find_by(id: params[:id])

    if @tweet&.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def mark_complete
    @tweet = tweet.find_by(id: params[:id])

    render 'tweets/tweets' if @tweet&.tweets(completed: true)
  end

  def mark_active
    @tweet = tweet.find_by(id: params[:id])

    render 'tweets/tweets' if @tweet&.tweets(completed: false)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
