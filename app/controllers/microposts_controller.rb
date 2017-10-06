class MicropostsController < ApplicationController  
  
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,only: :destroy
  
  #protect_from_forgery with: :reset_session 


  def create

    message=""
    repeat_course=0

    params[:courses].each do |cou|  

      if(current_user.microposts.find_by(content: get_abstract(cou))==nil)

        @micropost = current_user.microposts.build(content: get_abstract(cou))

        if @micropost.save

          if(message!="")
            message+=" || "+cou
          else
            message+=cou
          end  
        else
          @feed_items = []
          #render root_url
          redirect_to root_url
          return
        end
      else 
        repeat_course=1
      end

    end

    if message=="" && repeat_course==1
      flash[:danger] = "请不要重复选课哦！"
      @feed_items = []
      redirect_to root_url
      repeat_course=0
    elsif message==""
      flash[:danger] = "请选择课程~"
      @feed_items = []
      redirect_to root_url
    else
      if @micropost.save
        flash[:success] = "已添加课程："+message
        redirect_to root_url
      else
        @feed_items = []
        #render static_pages/home
        redirect_to root_url
      end
    end
  
  end

  def destroy
    @micropost.destroy
    flash[:danger] = "课程已退选！"
    redirect_to request.referrer || root_url
  end


  
  #skip_before_filter :verify_authenticity_token  
 # config.middleware.use ActionDispatch::Flash
  
  

  
  private
    def micropost_params 
      params.require(:micropost).permit(:content)
    end
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id]) 
      redirect_to root_url if @micropost.nil?
    end

    def get_abstract(cou)
      tmp_str=""
      now_course=Course.find_by(name:cou)
      tmp_str="%s || %s || %s || %s || %.1f学分"%[now_course.name,now_course.teacher,now_course.time,
        now_course.course_class,now_course.credit]
    
    end
  #skip_before_filter :verify_authenticity_token

end
