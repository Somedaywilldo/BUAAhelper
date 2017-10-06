# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

A=Course.new
A.update_attributes(name: "工科数学分析", teacher: "杨小远", time: "周二3、4节", place: "教3-106", volume: 160, now_selected: 0,course_id:"B1A012130",course_class: "数学与自然科学类",required: "必修",credit: 5.0)

A=Course.new
A.update_attributes(name: "数据结构", teacher: "晏海华", time: "周五5、6节", place: "教3-306", volume: 50, now_selected: 10,course_id:"B2B032130",course_class: "核心专业类",required: "必修",credit: 4.0)

A=Course.new
A.update_attributes(name: "计算机组成原理", teacher: "高小鹏", time: "周三3、4节；周五3、4节", place: "教2-306", volume: 80,course_id:"B3A012140",course_class: "核心专业类",required: "必修",credit: 7.0)

A=Course.new
A.update_attributes(name: "批判式阅读与写作", teacher: "张欣叶", time: "周四1、2节", place: "教5-210", volume: 30, now_selected: 0,course_id:"B1C012450",course_class: "语言类",required: "必修",credit: 2.0)

A=Course.new
A.update_attributes(name: "体育：散打", teacher: "周若夫", time: "周二5节", place: "操场", volume: 30, now_selected: 0,course_id:"B1D012340",course_class: "体育类",required: "必修",credit: 0.5)

A=Course.new
A.update_attributes(name: "舞蹈之美", teacher: "井志伟", time: "周三7、8节", place: "舞蹈排练室", volume: 30, now_selected: 3,course_id:"B10765430",course_class: "核心通识类",required: "选修",credit: 2.0)

A=Course.new
A.update_attributes(name: "发明、创新与创业", teacher: "雷鹏", time: "周四1、2节", place: "教4-104", volume: 30, now_selected: 0,course_id:"B1G013340",course_class: "一般通识类",required: "选修",credit: 2.0)
