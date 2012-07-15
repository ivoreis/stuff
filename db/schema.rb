# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120610115340) do

  create_table "action_permissions", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "activities", :force => true do |t|
    t.integer  "traceable_id",   :null => false
    t.string   "traceable_type", :null => false
    t.integer  "owner_id",       :null => false
    t.string   "owner_type",     :null => false
    t.string   "key",            :null => false
    t.text     "parameters"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["traceable_id", "traceable_type"], :name => "index_activities_on_traceable_id_and_traceable_type"

  create_table "attachments", :force => true do |t|
    t.integer  "attached_at_id"
    t.string   "attached_at_type"
    t.string   "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "attachments", ["attached_at_id", "attached_at_type"], :name => "index_attachments_on_attached_at_id_and_attached_at_type"

  create_table "comment_versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "comment_versions", ["item_type", "item_id"], :name => "index_comment_versions_on_item_type_and_item_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",                   :null => false
    t.string   "commentable_type",                 :null => false
    t.integer  "commenter_id",                     :null => false
    t.string   "commenter_type",                   :null => false
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commenter_id"], :name => "index_comments_on_commenter_id"

  create_table "conversations", :force => true do |t|
    t.integer  "originator_id",                      :null => false
    t.string   "originator_type",                    :null => false
    t.boolean  "group",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "conversations", ["originator_id", "originator_type"], :name => "index_conversations_on_originator_id_and_originator_type"

  create_table "events", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "title"
    t.text     "details"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day"
    t.boolean  "repeat"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "events", ["creator_id", "creator_type"], :name => "index_events_on_creator_id_and_creator_type"
  add_index "events", ["owner_id", "owner_type"], :name => "index_events_on_owner_id_and_owner_type"

  create_table "expression_items", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "content",    :null => false
    t.integer  "owner_id",   :null => false
    t.string   "owner_type", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "expression_items", ["owner_id", "owner_type"], :name => "index_expression_items_on_owner_id_and_owner_type"

  create_table "favorites", :force => true do |t|
    t.integer  "favorable_id",   :null => false
    t.string   "favorable_type", :null => false
    t.integer  "favoriter_id",   :null => false
    t.string   "favoriter_type", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "favorites", ["favorable_id", "favorable_type"], :name => "index_favorites_on_favorable_id_and_favorable_type"
  add_index "favorites", ["favoriter_id", "favoriter_type"], :name => "index_favorites_on_favoriter_id_and_favoriter_type"

  create_table "followships", :force => true do |t|
    t.integer  "sender_id",     :null => false
    t.integer  "receiver_id",   :null => false
    t.string   "receiver_type", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "followships", ["sender_id", "receiver_id", "receiver_type"], :name => "index_followships", :unique => true

  create_table "forum_memberships", :force => true do |t|
    t.integer  "room_id"
    t.integer  "member_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forum_memberships", ["room_id", "member_id"], :name => "index_forum_memberships_on_room_id_and_member_id", :unique => true

  create_table "forum_moderations", :force => true do |t|
    t.integer  "room_id",      :null => false
    t.integer  "moderator_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "forum_moderations", ["room_id", "moderator_id"], :name => "index_forum_moderations_on_room_id_and_moderator_id", :unique => true

  create_table "forum_rooms", :force => true do |t|
    t.string   "title",                            :null => false
    t.string   "description",                      :null => false
    t.boolean  "public",        :default => true
    t.boolean  "institutional", :default => false
    t.string   "slug",                             :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "forum_rooms", ["slug"], :name => "index_forum_rooms_on_slug", :unique => true

  create_table "forum_subscriptions", :force => true do |t|
    t.integer  "subscriber_id", :null => false
    t.integer  "topic_id",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "forum_subscriptions", ["subscriber_id", "topic_id"], :name => "index_forum_subscriptions_on_subscriber_id_and_topic_id", :unique => true

  create_table "forum_topics", :force => true do |t|
    t.string   "title",                         :null => false
    t.integer  "owner_id",                      :null => false
    t.integer  "room_id",                       :null => false
    t.text     "content",                       :null => false
    t.boolean  "pinned",     :default => false
    t.string   "slug",                          :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "forum_topics", ["slug"], :name => "index_forum_topics_on_slug", :unique => true

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "library_items", :force => true do |t|
    t.string   "description", :null => false
    t.string   "author",      :null => false
    t.string   "title",       :null => false
    t.integer  "owner_id",    :null => false
    t.string   "owner_type",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "library_items", ["owner_id", "owner_type"], :name => "index_library_items_on_owner_id_and_owner_type"

  create_table "list_permissions", :force => true do |t|
    t.integer  "named_list_id", :null => false
    t.integer  "permission_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "list_permissions", ["named_list_id", "permission_id"], :name => "index_list_permissions_on_named_list_id_and_permission_id", :unique => true

  create_table "mentions", :force => true do |t|
    t.integer  "originator_id",              :null => false
    t.string   "originator_type",            :null => false
    t.integer  "mentionable_id",             :null => false
    t.string   "mentionable_type",           :null => false
    t.integer  "mentionable_container_id",   :null => false
    t.string   "mentionable_container_type", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "mentions", ["mentionable_container_id", "mentionable_container_type"], :name => "index_mentions_on_mentionable_container"
  add_index "mentions", ["mentionable_id", "mentionable_type"], :name => "index_mentions_on_mentionable"
  add_index "mentions", ["originator_id", "originator_type"], :name => "index_mentions_on_originator"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id",                       :null => false
    t.string   "sender_type",                     :null => false
    t.integer  "conversation_id",                 :null => false
    t.text     "body",                            :null => false
    t.string   "subject",         :default => ""
    t.string   "attachment",      :default => ""
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "messages", ["conversation_id"], :name => "index_messages_on_conversation_id"
  add_index "messages", ["sender_id", "sender_type"], :name => "index_messages_on_sender_id_and_sender_type"

  create_table "named_list_entries", :force => true do |t|
    t.integer  "named_list_id", :null => false
    t.integer  "person_id",     :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "named_list_entries", ["named_list_id", "person_id"], :name => "index_named_list_entries_on_named_list_id_and_person_id", :unique => true

  create_table "named_lists", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "named_lists", ["owner_id", "name"], :name => "index_named_lists_on_owner_id_and_name", :unique => true
  add_index "named_lists", ["owner_id"], :name => "index_named_lists_on_owner_id"

  create_table "notifications", :force => true do |t|
    t.integer  "sender_id",                               :null => false
    t.string   "sender_type",                             :null => false
    t.integer  "notified_object_id",                      :null => false
    t.string   "notified_object_type",                    :null => false
    t.integer  "destination_id",                          :null => false
    t.string   "destination_type",                        :null => false
    t.boolean  "read",                 :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "notifications", ["destination_id", "destination_type"], :name => "index_notifications_on_destination"
  add_index "notifications", ["notified_object_id", "notified_object_type"], :name => "index_notifications_on_notified_object"
  add_index "notifications", ["sender_id", "sender_type"], :name => "index_notifications_on_sender"

  create_table "people", :force => true do |t|
    t.integer  "owner_id"
    t.string   "slug",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "people", ["owner_id"], :name => "index_people_on_owner_id"
  add_index "people", ["slug"], :name => "index_people_on_slug", :unique => true

  create_table "permissions", :force => true do |t|
    t.integer "action_permission_id",    :null => false
    t.integer "predicate_permission_id", :null => false
    t.string  "options"
  end

  add_index "permissions", ["action_permission_id", "predicate_permission_id"], :name => "unique_index_permissions", :unique => true

  create_table "person_profile_versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "person_profile_versions", ["item_type", "item_id"], :name => "index_person_profile_versions_on_item_type_and_item_id"

  create_table "person_profiles", :force => true do |t|
    t.integer  "person_id",                  :null => false
    t.string   "name"
    t.date     "birthday"
    t.string   "gender"
    t.string   "country"
    t.text     "bio"
    t.text     "about"
    t.string   "avatar",     :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "person_profiles", ["person_id"], :name => "index_person_profiles_on_person_id", :unique => true

  create_table "person_roles", :force => true do |t|
    t.integer "person_id", :null => false
    t.string  "name",      :null => false
  end

  add_index "person_roles", ["person_id"], :name => "index_person_roles_on_person_id", :unique => true

  create_table "predicate_permissions", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "receipts", :force => true do |t|
    t.integer  "recipient_id",                    :null => false
    t.integer  "message_id",                      :null => false
    t.boolean  "read",         :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "receipts", ["message_id"], :name => "index_receipts_on_message_id"
  add_index "receipts", ["recipient_id"], :name => "index_receipts_on_recipient_id"

  create_table "recipients", :force => true do |t|
    t.integer  "conversation_id", :null => false
    t.integer  "receiver_id",     :null => false
    t.string   "receiver_type",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "recipients", ["conversation_id", "receiver_id", "receiver_type"], :name => "index_recipients_on_conversation_receiver", :unique => true

  create_table "subject_permissions", :force => true do |t|
    t.integer  "permission_id", :null => false
    t.integer  "owner_id",      :null => false
    t.string   "owner_type",    :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "subject_permissions", ["permission_id", "owner_id", "owner_type"], :name => "index_subject_permissions", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",                       :null => false
    t.integer  "taggable_id",                  :null => false
    t.string   "taggable_type",                :null => false
    t.integer  "tagger_id",                    :null => false
    t.string   "tagger_type",                  :null => false
    t.string   "context",       :limit => 128
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["tagger_id", "tagger_type"], :name => "index_taggings_on_tagger_id_and_tagger_type"

  create_table "tags", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "timeline_entries", :force => true do |t|
    t.integer  "timeline_id",                      :null => false
    t.integer  "visibility_id",                    :null => false
    t.integer  "owner_id",                         :null => false
    t.string   "owner_type",                       :null => false
    t.string   "content_type",                     :null => false
    t.text     "content",                          :null => false
    t.boolean  "system",        :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "timeline_entries", ["owner_id", "owner_type"], :name => "index_timeline_entries_on_owner_id_and_owner_type"
  add_index "timeline_entries", ["timeline_id", "visibility_id"], :name => "index_timeline_entries_on_timeline_id_and_visibility_id"

  create_table "timelines", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "timelines", ["owner_id", "owner_type"], :name => "index_timelines_on_owner_id_and_owner_type", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "views", :force => true do |t|
    t.integer  "viewer_id",                                           :null => false
    t.string   "viewer_type",                                         :null => false
    t.integer  "viewable_id",                                         :null => false
    t.string   "viewable_type",                                       :null => false
    t.integer  "times_viewed",     :default => 1
    t.datetime "past_time_viewed", :default => '2012-07-04 14:43:36'
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "views", ["viewable_id", "viewable_type"], :name => "index_views_on_viewable_id_and_viewable_type"
  add_index "views", ["viewer_id", "viewer_type", "viewable_id", "viewable_type"], :name => "unique_index_view", :unique => true
  add_index "views", ["viewer_id", "viewer_type"], :name => "index_views_on_viewer_id_and_viewer_type"

  create_table "votes", :force => true do |t|
    t.integer  "votable_id",   :null => false
    t.string   "votable_type", :null => false
    t.integer  "voter_id",     :null => false
    t.string   "voter_type",   :null => false
    t.boolean  "vote_flag"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "votable_id", "votable_type"], :name => "unique_index_votes", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
