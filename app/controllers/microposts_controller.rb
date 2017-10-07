require 'aws-sdk'
require 'aws-sdk-sqs'

class MicropostsController < ApplicationController  
  
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,only: :destroy
  
  #protect_from_forgery with: :reset_session 


  def create

    if(params[:refresh]!=nil)
      flash[:success] = "刷新选课状态成功！"
      redirect_to root_url
      return
    end

    message=""
    repeat_course=0

    sqs = Aws::SQS::Client.new(
    access_key_id: 'AKIAPNCADUXD3HUR2QMQ',
    secret_access_key: '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'
    )      
    queue_url='https://sqs.cn-north-1.amazonaws.com.cn/444376591338/BUAAhelper'  

    if params[:courses]==nil
      flash[:danger] = "请选择课程"
      redirect_to root_url
    else
      params[:courses].each do |cou|  

        current_course=Course.find_by(name:cou)
        if(message!="")
          message+=" || "+cou
        else
          message+=cou
        end  
        send_message_result = sqs.send_message({
          queue_url: queue_url, 
            message_body: "Course request.",
            message_attributes: {
              "user_school_number" => {
                string_value: current_user.school_number,
                data_type: "String"
              },
              "course_course_id" => {
                string_value: current_course.course_id,
                data_type: "String"
              },
              "action" => {
                string_value: "add",
                data_type: "String"
              }
            }
        })
      end
      flash[:success] = "已添加以下课程至选课队列："+message+" -----选课期间在线用户多，请耐心等待服务器响应，不要频繁点击查看按钮~"
      redirect_to root_url
    end
    
      '''
      if(current_user.microposts.find_by(content: get_abstract(cou))==nil)

        @micropost = current_user.microposts.build(content: get_abstract(cou))

        if @micropost.save

          tmp_cou=Course.find_by(name:cou)
          tmp_cou.now_selected+=1
          tmp_cou.save

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
      '''

    

    '''
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
        flash[:success] = "已添加以下课程到选课队列："+message
        redirect_to root_url
      else
        @feed_items = []
        #render static_pages/home
        redirect_to root_url
      end
    end
    '''
  
  end

  def destroy
    cou=@micropost.content.split(" || ")[0]

    #flash[:danger] = a

    tmp_cou=Course.find_by(name:cou)
    tmp_cou.now_selected-=1
    tmp_cou.save

    @micropost.destroy
    #flash[:danger] = "课程已退选！"
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
