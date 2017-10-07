#http://guides.rubyonrails.org/active_job_basics.html
class ChooseCourseJob < ApplicationJob
  queue_as :default

  def perform()
    # Do something later
    queue_url='https://sqs.cn-north-1.amazonaws.com.cn/444376591338/BUAAhelper'
    sqs= Aws::SQS::Client.new
    receive_message_result = sqs.receive_message({
	  queue_url: queue_url, 
	  message_attribute_names: ["All"], # Receive all custom attributes.
	  max_number_of_messages: 1, # Receive at most one message.
	  wait_time_seconds: 0 # Do not wait to check for the message.
	})

    receive_message_result.messages.each do |message|
	  puts message.body 
	  puts "user_school_number: #{message.message_attributes["user_school_number"]["string_value"]}"
	  puts "course_course_id: #{message.message_attributes["course_course_id"]["string_value"]}"
	  puts "action: #{message.message_attributes["action"]["string_value"]}"  


	  current_user=User.find_by(school_number:
	  			message.message_attributes["user_school_number"]["string_value"])
	  current_course=Course.find_by(course_id:
	  			message.message_attributes["course_course_id"]["string_value"])
	  
	  cou=current_course.name

      if(current_user.microposts.find_by(content: get_abstract(cou))==nil)

        @micropost = current_user.microposts.build(content: get_abstract(cou))

        if @micropost.save

          current_course.now_selected+=1
          current_course.save

        end
      end

    

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



	  #Delete the message from the queue.
	  sqs.delete_message({
	    queue_url: queue_url,
	    receipt_handle: message.receipt_handle    
	  })
	end
  end

  private 
  	def get_abstract(cou)
      tmp_str=""
      now_course=Course.find_by(name:cou)
      tmp_str="%s || %s || %s || %s || %.1f学分"%[now_course.name,now_course.teacher,now_course.time,
        now_course.course_class,now_course.credit]
    end
end
