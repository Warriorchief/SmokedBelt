class UserController < ApplicationController
  def index
  end

  def register
      @new_user = User.new(name:params[:name],alias:params[:alias],email:params[:email],password:params[:password])
      if @new_user.save
        session[:user_id]=@new_user.id
        flash[:success]=["Successfully registered, now please sign in!"]
        redirect_to('/already')
      else
        flash[:error]=@new_user.errors.full_messages
        redirect_to '/'
      end
  end

  def already
    render('already.html.erb')
  end

  def login
    @new_guy=User.find_by_email(params[:email])
    if @new_guy and @new_guy.authenticate(params[:logpass])
      session[:user_id]=@new_guy.id
      flash[:success]=["Successfully logged in!"]
      redirect_to("/profile/#{@new_guy.id}")
    else
      flash[:error]=["Invalid credentials!"]
      redirect_to('/already')
    end
  end

  def profile
    @user = User.find(params[:id])
    @unsorted_ideas=Idea.all
    @holder=[]
    for u in @unsorted_ideas
      @count=u.likes.count
      @holder<<[u,@count]
    end                         #this part was REALLY hard
    # puts "@holder is now:"
    # puts @holder
    @orderedholder=@holder.sort{|a,b| b[1]<=>a[1]}
    @ideas=[]
    for o in @orderedholder
      @ideas<<o[0]
    end
    # puts "@ideas should now be in order and is:"
    # puts @ideas
    render 'profile.html.erb'
  end

  def delete_idea
    @user_id=session[:user_id]
    Idea.destroy(params[:id])
    flash[:success]=["Event deleted!"]
    redirect_to("/profile/#{@user_id}")
  end

  def like_idea
    @user_id=session[:user_id]
    Like.create(idea_id:params[:id],user_id:@user_id)
    flash[:success]=["Like created!"]
    redirect_to("/profile/#{@user_id}")
  end

  def new_idea
    @user_id=session[:user_id]
    @new_idea=Idea.new(content:params[:content],user_id:@user_id)
    if @new_idea.save
      flash[:success]=["Idea created!"]
      redirect_to("/profile/#{@user_id}")
    else
      flash[:error]=@new_event.errors.full_messages
      redirect_to("/profile/#{@user_id}")
    end
  end

  def show_user
    @user=User.find(params[:id])
    render('showuser.html.erb')
  end

  def show_idea_likers
    @user=User.find(session[:user_id])
    @this_idea=Idea.find(params[:id])
    @writer=@this_idea.user
    puts "@this idea is:"
    puts @this_idea,@this_idea.content

    @likes_for_this=Like.where(idea_id:@this_idea.id)
    puts "@like_this is:"
    puts @likes_for_this

    @users_who_like=[]
    for l in @likes_for_this
      @users_who_like<<l.user
    end
    puts "@users_who_like is:"
    puts @users_who_like

    @unique_likers=@users_who_like.uniq
    puts "@unique_likers is:"
    puts @unique_likers
    render('display.html.erb')
  end

  def logout
    reset_session
    flash[:success]=["Successfully logged out, see you again soon!"]
    redirect_to('/')
  end

end
