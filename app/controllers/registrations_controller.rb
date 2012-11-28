class RegistrationsController < Devise::RegistrationsController 
    
    def create

        @user = User.create(params[:user])
        
        @user.save
          if @user.valid?
           
         
            @profile = Profile.create 
            @profile.user_id = @user.id
            @profile.save
          
          flash[:notice] = 'registrations.create.success'
          # @user.seed_aspects
          sign_in_and_redirect(:user, @user)

        else
          @user.errors.delete(:person)
          
          flash[:error] = @user.errors.full_messages.join(" - ")
          Rails.logger.info("event=registration status=failure errors='#{@user.errors.full_messages.join(', ')}'")
          render :new
        end
      
    end
    
    def token
        #@user = User.where(:id => params[:user_id]).first
        #@user.reset_authentication_token!
        redirect_to edit_user_registration_path(@user)
    end
    
end