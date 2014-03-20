class AuthenticationsController < ApplicationController

  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = current_user.authentications if current_user
  end

  # POST /authentications
  # POST /authentications.json
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'],omniauth['uid'])

    ### User had already been authenticated
    if authentication
      authentication.user.twitter_detail.create_or_update_from_omniauth(omniauth)
      flash[:notice] = "Authentication Successful"
      sign_in_and_redirect(:user, authentication.user)

    ### User needed authenticating but was signed in
    elsif current_user
      current_user.authentications.create!(provider: omniauth['provider'],uid: omniauth['uid'])
      current_user.twitter_detail.create_or_update_from_omniauth(omniauth)
      flash[:notice] = "Sign in Successful"
      redirect_to :new_scan_path

    ### User needed authenticating and wasn't signed in yet
    else
            puts "|Here|" + omniauth.inspect
      user = User.find(session[:user_id])
      user.authentications.build(provider: omniauth['provider'],uid: omniauth['uid'])
      user.twitter_detail = TwitterDetail.new
      user.twitter_detail.create_or_update_from_omniauth(omniauth)
      if user.save
        flash[:notice] = "Sign in Successful"
        sign_in_and_redirect(:user, user)
      else
        flash[:alert] = "Sign in Unsuccessful. Please try again."
        sign_in_and_redirect(:user, user)
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    respond_to do |format|
      format.html { redirect_to authentications_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_authentication
    @authentication = Authentication.find(params[:id])
  end
end
