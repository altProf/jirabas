require 'jira' # jira-ruby gem

module Jirabas

  Options = {
    username:         ENV['JIRA_USER'],
    password:         ENV['JIRA_PASS'],
    site:             'https://jira',
    context_path:     '',
    auth_type:        :basic,
    use_ssl:          true,
    ssl_verify_mode:  false
  }

  CurrentUser = Options[:username]

  def self.client
    @client ||= JIRA::Client.new(Options)
  end

  def self.my_in_progress_issues
    client.Issue.jql("assignee = #{CurrentUser} AND resolution = Unresolved AND status = 'In Progress' ORDER BY updatedDate DESC")
  end
  def self.issues_i_did_recently
    client.Issue.jql("assignee = #{CurrentUser} AND resolution != Unresolved AND updatedDate > '-2d'  ORDER BY updatedDate DESC")
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
  end

end

Jirabas.run if $0 == __FILE__
