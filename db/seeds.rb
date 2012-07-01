#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

HackTag.delete_all
User.delete_all

# hack_tag = HackTag.create(name: "朝ご飯を食べる")
# users = User.create([{
#   provider: "lzh",
#   name: "ちよこ"
# },
# {
#   provider: "lzh",
#   name: "あきこ"
# }])
# 
# users.first.customs.create(hack_tag: hack_tag)
# users.last.customs.create(hack_tag:  hack_tag)