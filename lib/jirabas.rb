require "jirabas/version"
require "jirabas/config"

require 'pry'
require 'jira' # jira-ruby gem
require 'active_support/core_ext/hash'
require 'trollop'
require 'highline'
#require 'retryable'

module Jirabas

  def self.client
    Config.init
    @client ||= JIRA::Client.new(Config.all)
  end

  def self.my_in_progress_issues
    client.Issue.jql("assignee = #{Config.username} AND resolution = Unresolved AND status = 'In Progress' ORDER BY updatedDate DESC")
  end
  def self.issues_i_did_recently
    client.Issue.jql("assignee = #{Config.username} AND resolution != Unresolved AND updatedDate > '-2d'  ORDER BY updatedDate DESC")
  end
  def self.assigned_to_me
    client.Issue.jql("assignee = #{Config.username} AND resolution = Unresolved ORDER BY updatedDate DESC")
    .map { |e| "#{e.key}: #{e.summary}"}
  end

  def self.what_am_i_doing
    my_in_progress_issues.map { |e| "#{e.key}: #{e.summary}"}
  end
  def self.what_did_i_do_recently
    issues_i_did_recently.map { |e| "#{e.key}: #{e.summary}"}
  end

  def self.run *args
    puts "I'm doing:\n"
    puts what_am_i_doing.join("\n").to_s

    puts "----------\nI did recently:\n"
    puts what_did_i_do_recently.join("\n").to_s

    puts "----------\nTo do:\n"
    puts assigned_to_me.join("\n").to_s
  end

end
