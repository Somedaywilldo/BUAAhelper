# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

A=Course.new
A.update_attributes(name: "工科数学分析", teacher: "杨小远", time: "周二3、4节", place: "教3-106", volume: 160, now_selected: 0)

A=Course.new
A.update_attributes(name: "数据结构", teacher: "晏海华", time: "周五5、6节", place: "教3-306", volume: 50, now_selected: 10)

A=Course.new
A.update_attributes(name: "计算机组成原理", teacher: "高小鹏", time: "周三3、4节；周五3、4节", place: "教2-306", volume: 80)

A=Course.new
A.update_attributes(name: "批判式阅读与写作", teacher: "张欣叶", time: "周四1、2节", place: "教5-210", volume: 30, now_selected: 0)

A=Course.new
A.update_attributes(name: "体育：散打", teacher: "周若夫", time: "周二5节", place: "操场", volume: 30, now_selected: 0)
