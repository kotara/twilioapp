require 'twilio-ruby'
class ReminderController < ApplicationController
# your Twilio authentication credentials
ACCOUNT_SID = 'ACbd3c6e9c02244c0293f66680cfbebaa5'
ACCOUNT_TOKEN = '4cd9bd691fd4bd2430fc2172ecd515b4'
# base URL of this application
BASE_URL = "http://afternoon-window-3794.heroku.com/reminder"
# Outgoing Caller ID you have previously validated with Twilio
CALLER_ID = '442033222275'

  def index
  end
  # Use the Twilio REST API to initiate an outgoing call
  def makecall
    if !params['number']
      redirect_to :action => '.', 'msg' => 'Invalid phone number'
      return
    end
    # parameters sent to Twilio REST API
    data = {
      :from => CALLER_ID,
      :to => params['number'],
      :url => BASE_URL + '/reminder',
    }
    begin
      client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      client.account.calls.create data
    rescue StandardError => bang
      redirect_to :action => '.', 'msg' => "Error #{bang}"
      return
    end
    redirect_to :action => '', 'msg' => "Calling #{params['number']}..."
  end

  # TwiML response that reads the reminder to the caller and presents a
  # short menu: 1. repeat the msg, 2. directions, 3. goodbye
  def reminder
    @sometext = 'very very long text'
    	respond_to do |format|
      format.xml
   	end    
    @post_to = BASE_URL + '/directions'
    render :action => "reminder.xml.erb", :layout => false 
  end

  # TwiML response that inspects the caller's menu choice:
  # - says good bye and hangs up if the caller pressed 3
  # - repeats the menu if caller pressed any other digit besides 2 or 3
  # - says the directions if they pressed 2 and redirect back to menu
  def directions
    if params['Digits'] == '3'
      redirect_to :action => 'goodbye'
      return
    end
    if !params['Digits'] or params['Digits'] != '2'
      redirect_to :action => 'reminder'
      return
    end
    @redirect_to = BASE_URL + '/reminder'
    render :action => "directions.xml.builder", :layout => false 
  end

  # TwiML response saying with the goodbye message. Twilio will detect no
  # further commands after the Say and hangup
  def goodbye
    render :action => "goodbye.xml.builder", :layout => false 
  end
end

