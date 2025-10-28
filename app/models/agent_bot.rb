# == Schema Information
#
# Table name: agent_bots
#
#  id           :bigint           not null, primary key
#  bot_config   :jsonb
#  bot_type     :integer          default("webhook")
#  description  :string
#  name         :string
#  outgoing_url :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint
#
# Indexes
#
#  index_agent_bots_on_account_id  (account_id)
#

# AgentBot represents an automated agent (bot) in the system.
# Bots can be associated with inboxes and can send messages.
# Currently, only webhook bots are supported, which send events to an outgoing URL.
class AgentBot < ApplicationRecord
  include AccessTokenable
  include Avatarable

  has_many :agent_bot_inboxes, dependent: :destroy_async
  has_many :inboxes, through: :agent_bot_inboxes
  has_many :messages, as: :sender, dependent: :nullify
  belongs_to :account, optional: true
  enum bot_type: { webhook: 0 }

  validates :outgoing_url, length: { maximum: Limits::URL_LENGTH_LIMIT }

  # Returns the display name of the bot.
  #
  # @return [String] the name of the bot
  def available_name
    name
  end

  # Prepares a hash of data for push events.
  #
  # @param inbox [Inbox, nil] the inbox to get the avatar from if the bot doesn't have one
  # @return [Hash] the data for push events
  def push_event_data(inbox = nil)
    {
      id: id,
      name: name,
      avatar_url: avatar_url || inbox&.avatar_url,
      type: 'agent_bot'
    }
  end

  # Prepares a hash of data for webhooks.
  #
  # @return [Hash] the data for webhooks
  def webhook_data
    {
      id: id,
      name: name,
      type: 'agent_bot'
    }
  end

  # Checks if the bot is a system-level bot.
  #
  # @return [Boolean] true if the bot is not associated with an account, false otherwise
  def system_bot?
    account.nil?
  end
end
