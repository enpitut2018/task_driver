class Mutations::StartContribution < GraphQL::Schema::Mutation
  graphql_name 'StartContributionMutation'
  null false

  argument :task_id, ID, required: true

  field :task, Types::TaskType, null: true
  field :contribution, Types::ContributionType, null: true
  field :errors, [String], null: false

  def resolve(task_id:)
    task = Task.find(task_id)
    contribution = Contribution.new(:user_id => context[:current_user].id, :task_id => task.id)
    
    if task.user_id != context[:current_user].id
      return { contribution: contribution, task: task, errors: ['specified task is not yours.'] }
    end

    if contribution.save && task.doing!
      group = Group.find(task.group_id)
      if (group.public == true)
        if Oauth.exists?(user_id: context[:current_user].id)
          tweet(context[:current_user].id, task, contribution)
        end
      end
      { contribution: contribution, task: task, errors: [] }
    else
      {
        contribution: contribution,
        errors: contribution.errors.full_messages
      }
    end
  end

  private
  def tweet(user_id, task, contribution)
    text = "今から#{task.name}に取り組みます！\n応援してください!\n("
    text += contribution.created_at.strftime("%Y/%m/%d %H:%M:%S") + ")\n"
    text += ENV['APPLICATION_FRONT_URL'] + "/" + task.user_id.to_s + "/" + task.group_id.to_s + "/" + task.id.to_s
    text += "\n#Folivora\n"

    oauth = Oauth.find_by(user_id: user_id)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = oauth.access_token
      config.access_token_secret = oauth.access_token_secret
    end
    
    begin
      client.update(text)
    rescue => exception
      puts(exception)
    end

  end
end