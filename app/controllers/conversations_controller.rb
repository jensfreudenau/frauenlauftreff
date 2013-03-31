class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation
  skip_before_filter :verify_authenticity_token, :only => [:untrash, :trash]

  def index
    if (params[:box].eql? "inbox") || (params[:box].nil?)
      @msg =  current_user.mailbox.inbox
      render 'inbox'

    elsif params[:box].eql? "sentbox"
      @msg = current_user.mailbox.sentbox
      render 'sentbox'
    end
  end

  def create
    recipient_ids = params['recipients']
    recipients    = User.where(id: recipient_ids).all
    conversation  = current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def show
    conversation.mark_as_read(current_user)
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  def destroy

    conversation.move_to_trash(current_user)

    respond_to do |format|
      format.html {
        if params[:location].present? and params[:location] == 'conversation'
          redirect_to conversations_path(:box => :trash)
        else
          redirect_to conversations_path(:box => @box, :page => params[:page])
        end
      }
      format.js {
        if params[:location].present? and params[:location] == 'conversation'
          render :js => "window.location = '#{conversations_path(:box => @box, :page => params[:page])}';"
        else
          render 'conversations/destroy'
        end
      }
    end
  end

  private
  def get_mailbox
    @mailbox = current_subject.mailbox
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
        when 0 then
          self
        when 1 then
          self[subkeys.first]
        else
          subkeys.map { |k| self[k] }
      end
    end
  end
end
